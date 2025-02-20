insert into categories (name) values ('html');
insert into categories (name) values ('css');
insert into categories (name) values ('javascript');

/* CSS spurningar og svör */

/* Spurning 1 */
insert into questions (category_id, question) values 
((select id from categories where name='css'), 
'Fyrir eftirfarandi HTML / for the following HTML:\n\n\n<div class=\"text\">\n  <h1 class=\"important text__title\">Halló heimur</p>\n</div>\n \n\nEr skilgreint CSS / there is defined CSS:\n\n\n.text {\n  font-size: 10px;\n  color: green;\n}\n\n.text .text__title {\n  font-size: 1.5em;\n}\n\n.important {\n  font-size: 2em;\n  color: red;\n}\n\n \n\nHvert af eftirfarandi er satt fyrir textann „Halló heimur“ eftir að búið er að reikna gildi?');

insert into answers (question_id, answer, correct) values 
((select id from questions where question like 'Fyrir eftirfarandi HTML%'), 'font-size: 20px;, color: green;', true),
((select id from questions where question like 'Fyrir eftirfarandi HTML%'), 'font-size: 15px;, color: red;', false),
((select id from questions where question like 'Fyrir eftirfarandi HTML%'), 'font-size: 20px;, color: red;', false),
((select id from questions where question like 'Fyrir eftirfarandi HTML%'), 'font-size: 15px;, color: green;', false);

/* Spurning 2 */
insert into questions (category_id, question) values 
((select id from categories where name='css'), 
'Ef við erum að nota nýtt gildi fyrir lit í CSS sem er ekki víst að sé stutt í öllum vöfrum, þá ættum við að');

insert into answers (question_id, answer, correct) values 
((select id from questions where question = 'Ef við erum að nota nýtt gildi fyrir lit í CSS sem er ekki víst að sé stutt í öllum vöfrum, þá ættum við að'), 'Skilgreina fallback gildi á undan nýja gildinu sem væri notað í stað þess ef það er ekki stutt', true),
((select id from questions where question = 'Ef við erum að nota nýtt gildi fyrir lit í CSS sem er ekki víst að sé stutt í öllum vöfrum, þá ættum við að'), 'Skilgreina fallback gildi á eftir nýja gildinu sem væri notað í stað þess ef það er ekki stutt.', false),
((select id from questions where question = 'Ef við erum að nota nýtt gildi fyrir lit í CSS sem er ekki víst að sé stutt í öllum vöfrum, þá ættum við að'), 'Setja upp JavaScript virkni sem bendir notanda á að sækja nýjan vafra sem styður gildið.', false),
((select id from questions where question = 'Ef við erum að nota nýtt gildi fyrir lit í CSS sem er ekki víst að sé stutt í öllum vöfrum, þá ættum við að'), 'Þetta er ekki stutt í CSS.', false);

/* Spurning 3 */
insert into questions (category_id, question) values 
((select id from categories where name='css'), 
'Í verkefnum höfum við unnið með „containers“ og „items“ sem hugtök, hvað á það við?');

insert into answers (question_id, answer, correct) values 
((select id from questions where question = 'Í verkefnum höfum við unnið með „containers“ og „items“ sem hugtök, hvað á það við?'), '„Flex container“ og „flex items; „grid container“ og „grid items“: greinarmunur á foreldri og börnum þegar flexbox og CSS grid er notað.', true),
((select id from questions where question = 'Í verkefnum höfum við unnið með „containers“ og „items“ sem hugtök, hvað á það við?'), '„Flex container“ og „flex items: greinarmunur á foreldri og börnum eingöngu þegar flexbox er notað.', false),
((select id from questions where question = 'Í verkefnum höfum við unnið með „containers“ og „items“ sem hugtök, hvað á það við?'), '„Grid container“ og „grid items“: greinarmunur á foreldri og börnum eingöngu þegar grid er notað.', false),
((select id from questions where question = 'Í verkefnum höfum við unnið með „containers“ og „items“ sem hugtök, hvað á það við?'), 'Hugtök sem eru notuð með `querySelectorAll`: „container“ er það element sem leitað er undir, „items“ það sem er skilað.', false);

/* Spurning 4 */
insert into questions (category_id, question) values 
((select id from categories where name='css'), 
'Þegar við notum flexbox hvað af eftirfarandi er satt? Gerið ráð fyrir að skjal sé lesið frá vinstri til hægri.');

insert into answers (question_id, answer, correct) values 
((select id from questions where question = 'Þegar við notum flexbox hvað af eftirfarandi er satt? Gerið ráð fyrir að skjal sé lesið frá vinstri til hægri.'), 'Höfum skilgreinda tvo ása: aðalás og krossás sem eru hornréttir; sjálfgefin röðun er á aðalás frá vinstri til hægri.', true),
((select id from questions where question = 'Þegar við notum flexbox hvað af eftirfarandi er satt? Gerið ráð fyrir að skjal sé lesið frá vinstri til hægri.'), 'Höfum skilgreinda tvo ása: aðalás og krossás sem eru samsíða; sjálfgefin röðun er á aðalás frá vinstri til hægri.', false),
((select id from questions where question = 'Þegar við notum flexbox hvað af eftirfarandi er satt? Gerið ráð fyrir að skjal sé lesið frá vinstri til hægri.'), 'Höfum skilgreinda tvo ása: aðalás og krossás sem eru hornréttir; sjálfgefin röðun er á krossás frá vinstri til hægri.', false),
((select id from questions where question = 'Þegar við notum flexbox hvað af eftirfarandi er satt? Gerið ráð fyrir að skjal sé lesið frá vinstri til hægri.'), 'Höfum skilgreinda tvo ása: aðalás og krossás sem eru samsíða; sjálfgefin röðun er á krossás frá vinstri til hægri.', false);

/* HTML spurningar og svör */

/* Spurning 1 */
insert into questions (category_id, question) values 
((select id from categories where name='html'), 
'Ef við værum að smíða vefsíðu og myndum vilja geta farið frá index.html yfir á about.html, hvað væri best að nota?');

insert into answers (question_id, answer, correct) values 
((select id from questions where question = 'Ef við værum að smíða vefsíðu og myndum vilja geta farið frá index.html yfir á about.html, hvað væri best að nota?'), '<a href="about.html">About</a>', true),
((select id from questions where question = 'Ef við værum að smíða vefsíðu og myndum vilja geta farið frá index.html yfir á about.html, hvað væri best að nota?'), '<form method="get" action="about.html"><button>About</button></form>', false),
((select id from questions where question = 'Ef við værum að smíða vefsíðu og myndum vilja geta farið frá index.html yfir á about.html, hvað væri best að nota?'), '<button to="about.html">About</button>', false),
((select id from questions where question = 'Ef við værum að smíða vefsíðu og myndum vilja geta farið frá index.html yfir á about.html, hvað væri best að nota?'), 'Allar jafn góðar / All equally good', false);

/* Spurning 2 */
insert into questions (category_id, question) values 
((select id from categories where name='html'), 
'Í <head> á vefjum setjum við <meta charset="utf-8"> (eða það stafasett sem nota á), afhverju er það gert?');

insert into answers (question_id, answer, correct) values 
((select id from questions where question = 'Í <head> á vefjum setjum við <meta charset="utf-8"> (eða það stafasett sem nota á), afhverju er það gert?'), 'Þannig að stafir birtist rétt.', true),
((select id from questions where question = 'Í <head> á vefjum setjum við <meta charset="utf-8"> (eða það stafasett sem nota á), afhverju er það gert?'), 'Skilgreining sem visual studio verður að hafa þannig að prettier virki rétt.', false),
((select id from questions where question = 'Í <head> á vefjum setjum við <meta charset="utf-8"> (eða það stafasett sem nota á), afhverju er það gert?'), 'Skilgreining sem aXe krefur okkur um til að vefur verði aðgengilegur.', false),
((select id from questions where question = 'Í <head> á vefjum setjum við <meta charset="utf-8"> (eða það stafasett sem nota á), afhverju er það gert?'), 'Ekkert af þessu.', false);

/* Spurning 3 */
insert into questions (category_id, question) values 
((select id from categories where name='html'), 
'Það sem við getum gert til að forrita aðgengilega vefi er');

insert into answers (question_id, answer, correct) values 
((select id from questions where question = 'Það sem við getum gert til að forrita aðgengilega vefi er'), 'Allt af þessu.', true),
((select id from questions where question = 'Það sem við getum gert til að forrita aðgengilega vefi er'), 'Nota eingöngu lyklaborð við að skoða og nota vefinn.', false),
((select id from questions where question = 'Það sem við getum gert til að forrita aðgengilega vefi er'), 'Merkja form á aðgengilegan hátt.', false),
((select id from questions where question = 'Það sem við getum gert til að forrita aðgengilega vefi er'), 'Hafa tóman alt texta á myndum ef þær eru eingöngu til skrauts.', false);

/* Spurning 4 */
insert into questions (category_id, question) values 
((select id from categories where name='html'), 
'Hvað er merkingarfræði í sambandi við námsefnið?');

insert into answers (question_id, answer, correct) values 
((select id from questions where question = 'Hvað er merkingarfræði í sambandi við námsefnið?'), 'Hvert HTML element hefur einhverja skilgreinda merkingu—merkingarfræðilegt gildi—sem við þurfum að hafa í huga þegar við smíðum vefi.', true),
((select id from questions where question = 'Hvað er merkingarfræði í sambandi við námsefnið?'), 'Hvert HTML tag hefur einhverja skilgreinda merkingu—merkingarfræðilegt gildi—sem við þurfum að hafa í huga þegar við smíðum vefi.', false),
((select id from questions where question = 'Hvað er merkingarfræði í sambandi við námsefnið?'), 'Hvert CSS eigindi hefur einhverja skilgreinda merkingu—merkingarfræðilegt gildi—sem við þurfum að hafa í huga þegar við smíðum vefi.', false),
((select id from questions where question = 'Hvað er merkingarfræði í sambandi við námsefnið?'), 'Hver CSS selector hefur einhverja skilgreinda merkingu—merkingarfræðilegt gildi—sem við þurfum að hafa í huga þegar við smíðum vefi.', false);

/* JavaScript spurningar og svör */

/* Spruning 1 */
insert into questions (category_id, question) values 
((select id from categories where name='javascript'), 
'Hvað er skrifað út eftir að eftirfarandi kóði er keyrður?\n\nconst items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];\n\nconst іtem = items\n  .map((i) => i * 2)\n  .filter(\n    (i) => i < 10\n  )\n  .find((i) => i > 6)\n\n\nconsole.log(item);');

insert into answers (question_id, answer, correct) values 
((select id from questions where question like 'Hvað er skrifað út eftir að eftirfarandi kóði er keyrður%'), '8', true),
((select id from questions where question like 'Hvað er skrifað út eftir að eftirfarandi kóði er keyrður%'), '[8]', false),
((select id from questions where question like 'Hvað er skrifað út eftir að eftirfarandi kóði er keyrður%'), 'Uncaught ReferenceError: item is not defined', false),
((select id from questions where question like 'Hvað er skrifað út eftir að eftirfarandi kóði er keyrður%'), 'undefined', false);

/* Spurning 2 */
insert into questions (category_id, question) values 
((select id from categories where name='javascript'), 
'Þegar við berum saman gildi í JavaScript ættum við alltaf að nota þrjú samasem merki (`===`) því að');

insert into answers (question_id, answer, correct) values 
((select id from questions where question = 'Þegar við berum saman gildi í JavaScript ættum við alltaf að nota þrjú samasem merki (`===`) því að'), 
'Þessi samanburður byrjar á að bera saman týpur gilda og kemst því framhjá type coercion sem gerist með samanburð með tveimur samasem merkjum.', true),
((select id from questions where question = 'Þegar við berum saman gildi í JavaScript ættum við alltaf að nota þrjú samasem merki (`===`) því að'), 
'Við ættum alltaf að nota tvö samasem merki, ekki þrjú því þá byrjum við á að bera saman týpur gilda og komumst þannig framhjá type coercion.', false),
((select id from questions where question = 'Þegar við berum saman gildi í JavaScript ættum við alltaf að nota þrjú samasem merki (`===`) því að'), 
'Þessi samanburður kemst framhjá truthy og falsy gildum og skilar eingöngu réttum niðurstöðum fyrir primitive gildi.', false),
((select id from questions where question = 'Þegar við berum saman gildi í JavaScript ættum við alltaf að nota þrjú samasem merki (`===`) því að'), 
'Þessi samanburður nýtir lógíska virkja sem virka aðeins í tvístæðum.', false);

/* Spurning 3 */
insert into questions (category_id, question) values 
((select id from categories where name='javascript'), 
'Þegar við notum `fetch` í JavaScript ætti ferlið við að sækja gögn að vera');

insert into answers (question_id, answer, correct) values 
((select id from questions where question = 'Þegar við notum `fetch` í JavaScript ætti ferlið við að sækja gögn að vera'), 
'Búið til `fetch` request kall sem tilgreinir að minnsta kosti URL; villuathugun á kalli og svari með tilliti til HTTP; gögn sótt í response með villuathugun.', true),
((select id from questions where question = 'Þegar við notum `fetch` í JavaScript ætti ferlið við að sækja gögn að vera'), 
'Búið til `fetch` request kall sem verður að tilgreina URL, HTTP aðferð og stöðukóða; villuathugun á kalli og svari með tilliti til HTTP; gögn sótt í response með villuathugun.', false),
((select id from questions where question = 'Þegar við notum `fetch` í JavaScript ætti ferlið við að sækja gögn að vera'), 
'Búið til `fetch` request kall sem tilgreinir að minnsta kosti URL; villuathugun á kalli og svari með tilliti til URL; gögn sótt í response.', false),
((select id from questions where question = 'Þegar við notum `fetch` í JavaScript ætti ferlið við að sækja gögn að vera'), 
'Búið til `fetch` request kall sem tilgreinir að minnsta kosti URL; villuathugun á kalli og svari með tilliti til HTTP; eingöngu JSON gögn sótt í response með villuathugun.', false);
