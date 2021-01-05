=== debarquer(destination)===
~ temp dest_pavillon = pavillonOf(destination)
{dest_pavillon != PavillonColor:
    Ce serait suicidaire de débarquer là-bas sous {verbosePavillon(PavillonColor)}
    -> hub_sea.hub_loop
}

{destination} # CLASS: location
~ temp tresor = tresorOf(destination)

Vous arrivez au port de {destination}, bien décidée à ramener {verboseTresor(tresor)} au bercail !

+ {!know(destination, location)}... mais vous ne savez pas par où commencer 
    -> need_more
+ {know(destination, location)}... vous trouvez rapidement le {verboseLocationOf(tresor)}

+ + {!know(destination, entry)}... mais vous ne savez pas comment y entrer
    -> need_more
+ + {know(destination, entry)}... vous savez qu'il faudra {verboseEntryOf(tresor)}

+ + + {!know(destination, escape)}... mais vous n'avez pas de méthode pour ressortir
    -> need_more
+ + + {know(destination, escape)}... puis fuir {verboseEscapeOf(tresor)}

-(steal_tresor)
    ~ Tresors += tresor
    {verboseTresor(tresor)} est à vous !
    -> depart

-(need_more) Quelques dîners en mer de plus vous permettront de glaner ces informations.
    -> depart
    

-(depart)
    Vous mettez les voiles ! #CLASS: didascalie
    -> hub_sea 