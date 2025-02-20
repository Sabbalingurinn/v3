CREATE TABLE IF NOT EXISTS public.categories (
  id serial primary key,
  name varchar(64) not null unique,
  created timestamp with time zone not null default current_timestamp
);

CREATE TABLE IF NOT EXISTS public.questions (
  id serial primary key,
  category_id integer references public.categories(id) ON DELETE CASCADE,
  question text not null
);

CREATE TABLE IF NOT EXISTS public.answers (
  id serial primary key,
  question_id integer references public.questions(id) ON DELETE CASCADE,
  answer text not null,
  correct boolean not null
);
