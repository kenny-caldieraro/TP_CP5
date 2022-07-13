# MLD

On effectue le MLD en suivant les instructions de la fiche récap

LIST ( id, name, position, created_at, updated_at )
CARD ( id, title, position, color, #LIST(id), created_at, updated_at )
LABEL ( id, name, color, created_at, updated_at  )
CARD_LABEL ( id, #CARD(id), #LABEL(id), created_at, updated_at  )

J'utilise le MLD ainsi créé pour ensuite réfléchir concrétement à mes tables et aux champs de celles-ci

list ( id INTEGER, name TEXT, position INTEGER created_at TIMESTAMPTZ, updated_at TIMESTAMPTZ)
card ( id INTEGER, description TEXT, position INTEGER, color TEXT, #list(id) INTEGER, created_at TIMESTAMPTZ, updated_at TIMESTAMPTZ)
tag ( id INTEGER, name TEXT, color TEXT, created_at TIMESTAMPTZ, updated_at TIMESTAMPTZ)
card_has_tag ( #card(id) INTEGER, #tag(id) INTEGER, created_at TIMESTAMPTZ)
