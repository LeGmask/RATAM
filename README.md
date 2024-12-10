TODO List:
- Test parser + lexer
- Test type.ml
- Support paramètres par défaut parser
- Ajouter commentaire passe typage
- Ajouter commentaire passe placement mémoire 




TESTS : 

- GESTION ID : 
    - sans fonction :
        - testUtilisation20 : bcp trop de chose ?
    - avec fonction : 
        - TODO


- TYPE : 
    - Affectation du null : 
        - sur pointeur : TODO
        - sur variables : testAffectation {10, 11, 12, 13}
    - Opérateur Adresse de : TODO
    - Fonctions : TODO

- PLACEMENT : tout à faire


- TAM : 
    - sans fonction : 
        - testPointeur1 : allocation new, dereference écriture, déreférence lecture
        - testPointeur2 : déf pointeur en référence à une variable sur le stack
        - testPointeur3 : déréférence read/write chaînée

    - avec fonction : 
        - testfun8: expression par défaut
        - testfun9: variable statique locale
        - testfun10 : utilisation var globale dans fonction
        - testfun11 : test retour pointeur / addresse
        - testfun12 : 
        - testfun13 : 