-- On démarre une transaction afin que celle-ci ne s'exécute que si toutes les opérations
-- se déroulent bien

-- list ( id INT, name TEXT, position INT created_at TIMESTAMPTZ, updated_at TIMESTAMPTZ)
-- card ( id INT, description TEXT, position INT, color TEXT, #list(id) INT, created_at TIMESTAMPTZ, updated_at TIMESTAMPTZ)
-- tag ( id INT, name TEXT, color TEXT, created_at TIMESTAMPTZ, updated_at TIMESTAMPTZ)
-- card_has_tag ( #card(id) INT, #tag(id) INT, created_at TIMESTAMPTZ)

BEGIN;

DROP TABLE IF EXISTS "list", 
"card", 
"tag", 
"card_has_tag";

-- Création de notre table list
CREATE TABLE "list" (
    -- Ici on utilise ALWAYS plutôt que BY DEFAULT pour empêcher la possibilité
    -- d'écraser l'id généré automatiquement par un id passé à la main
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name" TEXT NOT NULL DEFAULT '',
    "position" INT NOT NULL DEFAULT 0,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ
);

-- Création de notre table card
CREATE TABLE "card" (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "title" TEXT NOT NULL DEFAULT '',
    "position" INT NOT NULL DEFAULT 0,
    "color" TEXT NOT NULL DEFAULT '#FFF',
    -- On utilise ici la contrainte ON DELETE CASCADE pour s'assurer que si l'on supprime
    -- une liste, alors toutes les cartes possédant l'id de cette liste seront supprimées aussi
    "list_id" INT NOT NULL REFERENCES list("id") ON DELETE CASCADE,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ
);

-- Création de notre table tag
CREATE TABLE "label" (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name" TEXT NOT NULL DEFAULT '',
    "color" TEXT NOT NULL DEFAULT '#FFF',
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ
);

CREATE TABLE "card_label" (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "card_id" INT NOT NULL REFERENCES card("id") ON DELETE CASCADE,
    "label_id" INT NOT NULL REFERENCES label("id") ON DELETE CASCADE,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ
);

INSERT INTO "list" ("name", "position")
VALUES  ('IN PROGRESS', 2),
        ('TO DO', 1);

INSERT INTO "card" ("description", "position", "color", "list_id")
VALUES  ('Carte 1', 1, '#fff696', 1),
        ('Carte 2', 2, '#c1e7ff', 1);

INSERT INTO "tag" ("name", "color")
VALUES ('Urgent', '#F00');

-- On oublie pas la table de liaison !
INSERT INTO "card_has_tag" ("card_id", "tag_id")
VALUES (2, 1);

COMMIT;