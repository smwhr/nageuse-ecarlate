INCLUDE ecarlate/functions.ink
INCLUDE ecarlate/debarquer.ink
INCLUDE ecarlate/opensea.ink

LIST PavillonColors = (pirate), portuguese, british, dutch, (french)
VAR PavillonColor = pirate

LIST Tresors = tulipe, azulejos, rose
LIST Destinations = Batavia, Macau, Labuan

LIST Cargo = Food, Rum

LIST intel_types = location, entry, escape
LIST BataviaKnowledge = batavia_location, batavia_entry, batavia_escape
LIST MacauKnowledge = macau_location, macau_entry, macau_escape
LIST LabuanKnowledge = labuan_location, labuan_entry, labuan_escape
VAR Knowledge = ()

VAR LifePoints = 100

-> intro

== intro ==
Elle a fiere allure la Nageuse Ecarlate sur les eaux de la Mer d'Orient. 
+ Elle fend les vagues. 

->discalie_pavillon(false)->

-> hub_sea


-> DONE


=== hub_sea ===
Pleine mer # CLASS: location

-(hub_loop)
    {~ De là|Et maintenant} vous pouvez
    <- destinationChoiceList(Destinations, -> debarquer)
    + ... vous laisser porter par les vents
        -> random_encounter -> hub_sea
    + ... rentrer à Kinatuka
        -> kinatuka_end -> hub_loop
    + ... changer de pavillon
        -> suggest_pavillon -> hub_loop


=== discalie_pavillon(new) ==
Vous <> {new: 
        - true: hissez
        - false: portez
    } <> {verbosePavillon(PavillonColor)} #CLASS: didascalie
->->

=== suggest_pavillon ==
<- pavillonChoiceList(PavillonColors, -> hub_sea.hub_loop)
* [Annuler] ->->
->->


=== pavillonChoiceList(list, -> divert)===
    ~ temp current_pav = LIST_MIN(list)
    
    { LIST_COUNT(list) > 0 :
        <- pavillonChoiceList(list - current_pav, divert)
        + [Hisser {verbosePavillon(current_pav)}] 
            -> hisse_pavillon(current_pav) -> divert
        
    } 

=== destinationChoiceList(list, -> divert)===
    ~ temp current_dest = LIST_MIN(list)
    
    { LIST_COUNT(list) > 0 :
        <- destinationChoiceList(list - current_dest, divert)
        + {destination_reachable(current_dest)}[... rallier {verboseDestination(current_dest)}] 
            -> hisse_pavillon_for(current_dest) -> divert(current_dest)
        
    } 

=== function destination_reachable(destination)
    ~ temp tmp_tresor= tresorOf(destination)
    {Tresors has tmp_tresor:
        ~ return false
    }
    ~ return true

=== function verboseDestination(destination)
    ~ temp tmp_pavillon= pavillonOf(destination)
    {destination}<>
    {PavillonColors has tmp_pavillon:
        <> avec
    }
    {PavillonColors hasnt tmp_pavillon:
        , mais il vous faudrait
    }
    <> un {verbosePavillon(tmp_pavillon)}
    

=== hisse_pavillon(pavillon) ===
    {PavillonColors hasnt pavillon:
        Vous n'avez pas de {verbosePavillon(pavillon)} ->->
    }
    ~ temp isNew = pavillon != PavillonColor
    ~ PavillonColor = pavillon
    ->discalie_pavillon(isNew)->
    ->->

=== hisse_pavillon_for(destination) ===
{PavillonColors hasnt pavillonOf(destination): -> continue}
{destination:
    -Batavia: -> hisse_pavillon(dutch) ->
    -Macau: -> hisse_pavillon(portuguese) ->
    -Labuan: -> hisse_pavillon(british) ->
    }
-(continue)
->->


=== sank_end ===
<>
Fin
-> END

=== kinatuka_end ===
{ LIST_COUNT(Tresors) == 0 :
    - Hors de question de rentrer au bercail sans un trésor !
    ->->
    }
Kinatuka # CLASS: location
Vous débarquez sur Kinatuka, votre île d'adoption, avec <>
{LIST_COUNT(Tresors):
    -1 : un seul
    -2 : deux
    -3 : tous les
}<> trésor{LIST_COUNT(Tresors) > 1:s} une <>
{LIST_COUNT(Tresors):
    -1 : petite
    -2 : grande
    -3 : somptueuse
} <> fête a été organisée en votre honneur.
+ Repartir en mer
    -> hub_sea
+ Rester
    -> DONE
