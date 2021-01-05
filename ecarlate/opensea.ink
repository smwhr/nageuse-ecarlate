LIST BoatTypes = (Brick), (Goelette), (Corvette), (Fregate)
VAR TypeNavire = ()
VAR EnnemyPavillon = ()

VAR SelfStrength = 0
VAR SelfSpeed = 2


=== function strenghtOf(boatType)
{boatType:
    - Brick: 
        ~ return -3
    - Goelette: 
        ~ return -3
    - Corvette: 
        ~ return 0
    - Fregate: 
        ~ return 4
}

=== function speedOf(boatType)
{boatType:
    - Brick: 
        ~ return 1
    - Goelette: 
        ~ return 3
    - Corvette: 
        ~ return 2
    - Fregate: 
        ~ return 1
}


=== random_encounter ===
~ TypeNavire = LIST_RANDOM(LIST_ALL(BoatTypes))
~ EnnemyPavillon = LIST_RANDOM(LIST_ALL(PavillonColors))
~ temp EnnemyStrength = strenghtOf(TypeNavire)

{TypeNavire} portant {verbosePavillon(EnnemyPavillon)} à l'horizon !  #CLASS: event


Vous décidez de tenter
+ (chose_attack)... une attaque [<> {
            - SelfStrength > EnnemyStrength: car c'est une proie facile
            - SelfStrength <= EnnemyStrength: même si le combat s'avère 
                {
                    - SelfStrength == EnnemyStrength: <> serré
                    - SelfStrength < EnnemyStrength: <> perdu d'avance
                }
            }]
            -> attack -> random_encounter.end
+ (chose_run)... la fuite[{
                - PavillonColors has EnnemyPavillon and Cargo has Food and Cargo has Rum:  <>, il n'y a rien à gagner
                - else : <> malgré les opportunités
                }]
            -> run -> random_encounter.end
+ (chose_peace)... une approche pacifique [<>{
            - PavillonColors hasnt EnnemyPavillon: malgré votre {verbosePavillon(PavillonColor)}
            - else: en arborant un pavillon de même couleur
            }] 
            -> peace -> random_encounter.end
            
      
//- <> qui n'est pas du goût de votre adversaire ! {TURNS_SINCE(-> chose_attack)};{TURNS_SINCE(-> chose_run)} ; {TURNS_SINCE(->chose_peace)}

- (end) 
    Vous mettez les voiles ! #CLASS: didascalie
->->


=== combat( -> victory, -> defeat) ===

~ temp AttackSelf = RANDOM(1,6) 
~ temp AttackEnnemy = RANDOM(1,6) + strenghtOf(TypeNavire)

{
    - AttackSelf >= AttackEnnemy : Victoire ! #CLASS: event
    - AttackSelf < AttackEnnemy : 
                Défaite... #CLASS: event
                ~ LifePoints -= 20
}

La Nageuse Ecarlate <>{
    - LifePoints == 0: est {verboseLife()}. -> sank_end
    - else: s'en sort {verboseLife()}
}<>.
{AttackSelf < AttackEnnemy: -> defeat}
-> victory


=== attack ===
-> combat(->pillage, ->end)

-(pillage)
~ temp GetFood = RANDOM(1,6) < 4 and Cargo hasnt Food
~ temp GetRum = RANDOM(1,6) > 3 and Cargo hasnt Rum
{
    - GetFood  : ~ Cargo += Food
}
{
    - GetRum : ~ Cargo += Rum
}

{GetFood or GetRum: Vous récupérez {GetFood:{verbose(Food)}}{GetFood and GetRum: <> et <>}{GetRum:{verbose(Rum)}}.} #CLASS: didascalie

~ temp CanGetPavillon = RANDOM(1,3) > 2
~ temp GetPavillon = CanGetPavillon and PavillonColors hasnt EnnemyPavillon
{
    - not CanGetPavillon and PavillonColors hasnt EnnemyPavillon:
        Le {verbosePavillon(EnnemyPavillon)} est malheureusement irrécupérable. #CLASS: didascalie
    - GetPavillon : 
        Vous obtenez un {verbosePavillon(EnnemyPavillon)} #CLASS: didascalie
        ~ PavillonColors += EnnemyPavillon
}
{not GetFood and not GetRum and not GetPavillon: Vous repartez bredouille.}#CLASS: didascalie

-(end)
->->

=== run ===
->->

=== function consume(item) ===
~ Cargo -= item
Vous consommez {verbose(item)}. #CLASS: didascalie

=== peace ===
{
    - PavillonColors has EnnemyPavillon: 
        -> hisse_pavillon(EnnemyPavillon) -> docked
}
- (docked) Bord contre bord, votre homologue vous salue.

{Cargo hasnt Food or Cargo hasnt Rum: Vous auriez bien préparé} <>
{Cargo hasnt Food: un dîner} <>
{Cargo hasnt Food and Cargo hasnt Rum: ou} <>
{Cargo hasnt Rum: une beuverie} <>
{Cargo hasnt Food or Cargo hasnt Rum: mais il vous manque de quoi recevoir.}<>
{Cargo hasnt Food or Cargo hasnt Rum: À défaut, vous |Vous }<>
proposez :

~ temp ennemyDestination = originOf(EnnemyPavillon)
~ temp tresor = tresorOf(ennemyDestination)

+ {Cargo has Food}... un excellent repas [pour délier les langues]
    <>. La bonne chaire délie les langues et un convive vous confie
    ~ consume(Food)
    + + {Destinations hasnt ennemyDestination} ... que {verboseTresor(tresor)} est [...]  à {ennemyDestination} 
         ~ Destinations += ennemyDestination
         -> nothing_more
    + + {!know(ennemyDestination, location) and Destinations has ennemyDestination} ... que {verboseTresor(tresor)} de {ennemyDestination} est [...] dans le {verboseLocationOf(tresor)}
         ~ learn(ennemyDestination, location)
         -> nothing_more
    + + {!know(ennemyDestination, entry) and know(ennemyDestination, location)} ... qu'il suffit de [...]{verboseEntryOf(tresor)} pour accéder au {verboseLocationOf(tresor)}  de {ennemyDestination} 
         ~ learn(ennemyDestination, entry)
         -> nothing_more
    + + {!know(ennemyDestination, escape) and know(ennemyDestination, entry)} ... que vous pourrez fuir le {verboseLocationOf(tresor)}  de {ennemyDestination} [...] {verboseEscapeOf(tresor)}
        ~ learn(ennemyDestination, escape)
        -> all_is_known
    + + {know(ennemyDestination, escape)} ... une blague
        -> all_is_known
        
    
    - - (nothing_more) <> mais vous n'en tirerez rien de plus. 
        -> end
    - - (all_is_known) <> et c'est tout ce dont vous avez besoin pour dérober {verboseTresor(tresor)}.{PavillonColors hasnt pavillonOf(ennemyDestination): Ça et un {verbosePavillon( pavillonOf(ennemyDestination))} !} 
        -> end
    
+ {Cargo has Rum}... une tournée générale de rhum [pour embrumer les esprits]
    <>. L'équipage adverse endormi, vous en profitez pour 
    ~ consume(Rum)
    + + {PavillonColors hasnt EnnemyPavillon} ... voler un pavillon
        Une fois le méfait accompli vous mettez les voiles ! 
        ~ temp spotted = RANDOM(1,5) > 3 and SelfSpeed < speedOf(TypeNavire)
        {spotted:
                - true: mais votre victime s'est aperçue du vol, et, plus rapide, vous rattrape et vous attaque par surprise
                        -> combat(->get_pavillon, ->lose_pavillon)
                - else: -> get_pavillon
        }
    - - - (get_pavillon)
        Vous obtenez un {verbosePavillon(EnnemyPavillon)}. #CLASS: didascalie
         ~ PavillonColors += EnnemyPavillon
         -> end
    - - - (lose_pavillon)
        Le {verbosePavillon(EnnemyPavillon)} est perdu. #CLASS: didascalie
        -> end
        
    + + ... attaquer, même si cela peut nuire à votre réputation.
        -> attack ->
    + + ... vous reposer
        ~ temp treason = RANDOM(1,5) > 0 and EnnemyPavillon == PavillonColor
        {treason:
                - true: ... mais ces traîtres vous attaquent dans votre sommeil !
                        -> combat(->end, ->end)
                - else: <>.
                        -> end
        }
    
+ ... une simple entrevue avec le capitaine
    - - Il <>
    - - {Destinations has ennemyDestination: ne <>}
    - - vous apprend <>
    - - {Destinations has ennemyDestination: -> nothing}
    - - {Destinations hasnt ennemyDestination: -> learnt_destination}
    
    - - (nothing) rien de plus que vous ne sachiez déjà.
        ->end
    - - (learnt_destination) qu'il se rend à {ennemyDestination} pour voir {verboseTresor(tresorOf(ennemyDestination))}.
        ~ Destinations += ennemyDestination
- (end)  
->->