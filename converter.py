# coding: utf8




minifiedName = "minified"

list = ["Color.pde","Afficheur.pde","Debugger.pde","Theme.pde","Mode.pde","CanvasButton.pde","Jeu.pde","CatalogueJeux.pde","ModeJeu.pde","Plateformer1.pde","SampleGame.pde","gb.pde"]



f = open(minifiedName,"w", encoding='utf-8')
chaine = ""
for fn in list:
    fi = open(fn, encoding='utf-8')
    chaine += fi.read()+"\n\n// "+fn+" --------------------------------\n\n\n"
    fi.close()


f.write(chaine)


f.close()
