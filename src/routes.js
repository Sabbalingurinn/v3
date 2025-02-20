import express from "express";
import { getDatabase } from "./lib/db.client.js";


export const router = express.Router();

router.get("/", async (req, res) => {
  const result = await getDatabase()?.query("SELECT * FROM categories");

  const categories = result?.rows ?? [];

  console.log(categories);
  res.render("index", { title: "Forsíða", categories });
});

router.get("/spurningar/:categoryId", async (req, res) => {
  const { categoryId } = req.params;
  const db = getDatabase();

  // Sækjum nafnið á flokknum
  const categoryResult = await db?.query(
    "SELECT name FROM categories WHERE id = $1",
    [categoryId]
  );

  if (!categoryResult || categoryResult.rows.length === 0) {
    return res.status(404).send("Þessi flokkur fannst ekki.");
  }

  const categoryName = categoryResult.rows[0].name;

  // Sækjum allar spurningar og svör sem tengjast þessum flokki
  const questionsResult = await db?.query(
    `
    SELECT q.id as question_id, q.question, a.id as answer_id, a.answer, a.correct
    FROM questions q
    LEFT JOIN answers a ON q.id = a.question_id
    WHERE q.category_id = $1
    ORDER BY q.id, a.id
  `,
    [categoryId]
  );

  const questions = {};

  questionsResult?.rows.forEach((row) => {
    if (!questions[row.question_id]) {
      questions[row.question_id] = {
        id: row.question_id,
        question: row.question,
        answers: [],
      };
    }

    if (row.answer_id) {
      questions[row.question_id].answers.push({
        id: row.answer_id,
        answer: row.answer,
        correct: row.correct,
      });
    }
  });

  // Sendum categoryName + spurningar til category.ejs
  res.render("category", {
    title: categoryName,
    categoryName,
    questions: Object.values(questions),
  });
});

router.get("/form", async (req, res) => {
  try {
    const db = getDatabase();
    if (!db)
      return res
        .status(500)
        .render("error", {
          title: "Villa",
          message: "Database connection failed",
        });

    const result = await db.query("SELECT * FROM categories");
    const categories = result?.rows ?? [];

    res.render("form", { title: "Búa til flokk", categories });
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .render("error", { title: "Villa", message: "Failed to load form" });
  }
});

// Handle form submission (add question + create category if necessary)
router.post('/form', async (req, res) => {
  console.log("Received form data:", req.body);

  let { question, categoryName, answers, correctAnswer } = req.body;

  const db = getDatabase();
  if (!db) return res.status(500).send('Gat ekki tengst gagnagrunn');

  // Validate inputs
  if (!question || !categoryName || !answers || answers.length !== 4 || !correctAnswer) {
    console.log("Validation failed: Invalid data", req.body);
    return res.status(400).send('Ógild gögn - Gagna villur');
  }

  try {
    // Check if category exists
    let categoryResult = await db.query('SELECT id FROM categories WHERE name = $1', [categoryName]);
    let categoryId;

    if (categoryResult.rowCount > 0) {
      categoryId = categoryResult.rows[0].id;
    } else {
      const insertCategory = await db.query(
        'INSERT INTO categories (name) VALUES ($1) RETURNING id',
        [categoryName]
      );
      categoryId = insertCategory.rows[0].id;
    }

    // Insert question into DB
    const questionResult = await db.query(
      'INSERT INTO questions (category_id, question) VALUES ($1, $2) RETURNING id',
      [categoryId, question]
    );

    const questionId = questionResult.rows[0].id;

    // Ensure `correctAnswer` is always an array (in case only one answer is checked)
    if (!Array.isArray(correctAnswer)) {
      correctAnswer = [correctAnswer];
    }

    // Insert answers into DB
    for (let i = 0; i < answers.length; i++) {
      const isCorrect = correctAnswer.includes(i.toString()); // Check if index is in correctAnswer array
      await db.query(
        'INSERT INTO answers (question_id, answer, correct) VALUES ($1, $2, $3)',
        [questionId, answers[i].text, isCorrect]
      );
    }

    res.render('form-created', { title: 'Spurning búin til' });
  } catch (error) {
    console.error(error);
    res.status(500).send('Villa við skráningu spurningar');
  }
});
