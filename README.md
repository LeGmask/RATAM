TODO List:
- Test parser + lexer
- Test type.ml
- Support paramètres par défaut parser
- Ajouter commentaire passe typage
- Ajouter commentaire passe placement mémoire 




## TESTS : 

- GESTION ID : 
    - [ ] Pointeurs:
        - testUtilisation20 : tout
        - testDerefLecture1 : dereference identifiant non déclaré 
        - testDerefLecture2 : dereference identifiant déclaré 
        - testDerefEcriture1 : deref id non-déclaré
        - testDerefEcriture2 : deref id déclaré
        - testReference1 : reference id déclaré
        - testReference2 : reference id non-déclaré
        
    - [x] Globales :
        - testGlobales1 : déclaration de variables globales (avec et sans fonction)
        - testGlobales2 : déclaration de variables globales avec mauvaise initialisation (avec et sans fonction)
        - testGlobales3 : doubles déclaration (avec et sans fonction)
    - [x] StatiquesLocales :
        - testStatiquesLocales1 : déclaration de variables statiques locales (avec fonction)
        - testStatiquesLocales2 : déclaration de variables statiques locales avec mauvaise initialisation (avec fonction)
        - testStatiquesLocales3 : doubles déclaration (avec fonction)
    - [x] Paramètres par défaut :
        - testDefaut1 : ordre incorrect (valeur par défaut devant paramètre sans valeur par défaut)
        - testDefaut2 : valeur par défaut avec identifiants non-défini
        - testDefaut3 : valeur par défaut avec identifiant cyclique (ie le paramètre lui même)
        - testDefaut4 : valeur par défaut correct sur rat
        - testDefaut5 : valeurs par défaut multiples après variables sans (2 sans -> 2 avec)

<!-- - sans fonction :
    - testUtilisation20 : bcp trop de chose ?
- avec fonction : 
    - TODO -->


- TYPE : 
    - [ ] Pointeurs:
    - [x] Globales :
        - testAffectation14 : affectation de variables globales (sans fonction)
        - testAffectation15 : affectation de variables globales avec mauvais type (sans fonction)
        - testAffectation15 : affectation de variables globales avec mauvais type (sans fonction)

        - testDeclaration10 : déclaration de variables globales (sans fonction)
        - testDeclaration11 : déclaration de variables globales avec mauvais type (sans fonction)
        - testDeclaration12 : déclaration de variables globales avec mauvais type (sans fonction)

        - testRepetition7
        - testRepetition8
        - testRepetition9

        - testIdent10
        - testIdent11
        - testIdent12

        - testConditionnelle7
        - testConditionnelle8
        - testConditionnelle9
    - [ ] StatiquesLocales :
    - [ ] Paramètres par défaut :
<!-- - Affectation du null : 
    - sur pointeur : TODO
    - sur variables : testAffectation {10, 11, 12, 13}
- Opérateur Adresse de : TODO
- Fonctions : TODO -->

- PLACEMENT :
    - [ ] Pointeurs:
    - [ ] Globales :
    - [ ] StatiquesLocales :
    - [ ] Paramètres par défaut :


- TAM : 
    - [ ] Pointeurs:
    - [ ] Globales :
    - [ ] StatiquesLocales :
    - [ ] Paramètres par défaut :
    <!-- - sans fonction : 
        - testPointeur1 : allocation new, dereference écriture, déreférence lecture
        - testPointeur2 : déf pointeur en référence à une variable sur le stack
        - testPointeur3 : déréférence read/write chaînée

    - avec fonction : 
        - testfun8: expression par défaut
        - testfun9: variable statique locale
        - testfun10 : utilisation var globale dans fonction
        - testfun11 : test retour pointeur / addresse
        - testfun12 : 
        - testfun13 :  -->