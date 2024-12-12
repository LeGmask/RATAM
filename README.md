TODO List:
- Test parser + lexer
- Test type.ml
- Support paramètres par défaut parser
- Ajouter commentaire passe typage
- Ajouter commentaire passe placement mémoire 




## TESTS : 

- GESTION ID : 
    - [x] Pointeurs:
        - testUtilisation20 : tout
        - testDerefLecture1 : déréférence identifiant non déclaré 
        - testDerefLecture2 : déréférence identifiant déclaré 
        - testDerefEcriture1 : deref id non-déclaré
        - testDerefEcriture2 : deref id déclaré
        - testReference1 : reference id déclaré
        - testReference2 : reference id non-déclaré
        - testDerefNonPointeur1 : déréférence de bool
        - testDerefNonPointeur2 : déréférence d'int
        - testDerefNonPointeur3 : déréférence de rat
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


- TYPE : 
    - [x] Pointeurs:
        - testAppel14 : pointeur en paramètre de fonction bien typé
        - testAppel15 : pointeur en paramètre de fonction mal typé
        - testRetourFonction5 : pointeur en retour de fonction (bien typé)
        - testRetourFonction6 : pointeur en retour de fonction (mal typé)
        - testAffectation(17-29) : affectation pointeur mal typé (int sur pointeur)
        - testAffectation(20-22) : affectation pointeur par référence (bien typé)
        - testAffectation23 : affectation pointeur par références chaînées (bien typé)
        - testAffectation(24-32) : affectation variable type de base par pointeur 
        - testAffectation(33-36) : affectation pointeur null
        - testAffectation(37-39) : affectation pointeur null sur variable type de base
        - testDerefE(1-3) : déréférencement pointeur en écriture
        - testDerefL(1-3) : déréférencement pointeur en lecture
        - testIdent13 : utilisation identifiant bien typé
        - testIdent(14, 15) : utilisation identifiant avec mauvais type
        - testConditionnelle(10-13) : pointeur en condition
        - testNumerateur(6, 7) : affectation pointeur + pointeur en opérande
        - testDenominateur(6, 7) : affectation pointeur + pointeur en opérande
        - testPrint4 : affichae pointeur
        - testRationnel6 : pointeur dans déclaration rationnel
        - testRepetition10 : pointeur en condition
        - testDeclaration(13-30) : même chose que affectation mais à la déclaration

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
    - [x] Paramètres par défaut :
        - testDefaut1 : valeur par défaut bien typé
        - testDefaut2 : valeur par défaut mal typé 


- PLACEMENT :
    - [ ] Pointeurs:
    - [ ] Globales :
    - [ ] StatiquesLocales :
    - [ ] Paramètres par défaut :


- TAM : 
    - [x] Pointeurs:
        - testPointeur1 : allocation new, déréférence écriture, déreférence lecture (avec et sans fonction)
        - testPointeur2 : référence à une variable de la pile (avec et sans fonction)
        - testPointeur3 : référence à une variavle sur le tas, déréférence read/write chaînée (sans fonction uniquement)
    
    - [ ] Globales :
         - testfun10 : utilisation var globale dans fonction
         - testfun15 : masquage var globale

    - [ ] StatiquesLocales :
        - testfun9 : utilisation variable statique locale

    - [x] Paramètres par défaut :
        - testfun(8, 12) : valeur par défaut constante
        - testfun13 : valeur par défaut globale
        - testfun14 : valeur par défaut fonction

## CHOIX:
- Les valeurs par défauts sont traitées lors de la passe d'analyse syntaxique et sémantique. Lors de l'analyse des déclaration de fonction, une Table des Défauts (TDD) est remplie. Cette table fait l'association entre les identifians de fonctions déclarés et la liste des options d'expression. Lors de cette meme passe, lors du traitement des AppelFonction, la liste des expressions des paramètre lors de l'appel est complétée en conséquence. Ainsi, sont autorisés dans les expressions par défaut l'utilisation de tout les identifiants définis avant la définition de la fonction (fonctions déclaré avant et variables globales).(cf. testfun13 et testfun14 )

- Les variables globales sont masquables.