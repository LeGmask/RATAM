TODO List:
- Test parser + lexer
- Test type.ml
- Support paramètres par défaut parser
- Ajouter commentaire passe typage
- Ajouter commentaire passe placement mémoire 




## TESTS : 

- GESTION ID : 
    - [ ] Pointeurs:
    - [x] Globales :
        - testGlobales1 : déclaration de variables globales (avec et sans fonction)
        - testGlobales2 : déclaration de variables globales avec mauvaise initialisation (avec et sans fonction)
        - testGlobales3 : doubles déclaration (avec et sans fonction)
    - [x] StatiquesLocales :
        - testStatiquesLocales1 : déclaration de variables statiques locales (avec fonction)
        - testStatiquesLocales2 : déclaration de variables statiques locales avec mauvaise initialisation (avec fonction)
    - [ ] Paramètres par défaut :

<!-- - sans fonction :
    - testUtilisation20 : bcp trop de chose ?
- avec fonction : 
    - TODO -->


- TYPE : 
    - [ ] Pointeurs:
    - [ ] Globales :
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