=== function verbosePavillon(pavillon)
pavillon <>
{pavillon:
    - french: français :flag_fr: 
    - pirate: pirate :flag_pirate:
    - portuguese: portugais :flag_pr:
    - british: britannique :flag_uk:
    - dutch: hollandais :flag_du:
    - else : {pavillon}
}


=== function verboseTresor(tresor)
{tresor:
    - tulipe: la Tulipe de Rubis
    - azulejos: l'Azulejos de Saphir
    - rose: la Rose de Diamant
}

=== function verboseLife()
{LifePoints:
    - 0:  envoyée par le fond
    - 20: au bord du naufrage
    - 40: sévèrement endommagée
    - 60:  marquée par l'expérience
    - 80: avec quelques avaries mineures
    - 100: intacte
}

=== function tresorOf(destination)
~ temp tresor = ()
{destination:
    - Batavia: 
        ~ tresor = tulipe
    - Macau: 
        ~ tresor = azulejos
    - Labuan: 
        ~ tresor = rose
}
~ return tresor

=== function verboseLocationOf(tresor)
{tresor:
    - tulipe: Beffroi
    - azulejos: Jardin d'Hiver
    - rose: Bear & Tiger Public House
}

=== function verboseEntryOf(tresor)
{tresor:
    - tulipe: s'infiltrer par les égoûts
    - azulejos: soudoyer un garde
    - rose: passer par les toits
}

=== function verboseEscapeOf(tresor)
{tresor:
    - tulipe: en rappel par les remparts
    - azulejos: déguisé en jardinier
    - rose: en payant une tournee generale
}

=== function pavillonOf(destination)
{destination:
    - Batavia: 
        ~ return dutch
    - Macau: 
        ~ return portuguese
    - Labuan: 
        ~ return british
}

=== function originOf(pavillon)
{pavillon:
    - dutch: 
        ~ return Batavia
    - portuguese: 
        ~ return Macau
    - british: 
        ~ return Labuan
    - else:
        ~ return LIST_RANDOM(LIST_ALL(Destinations))
}

=== function knowledgeOf(destination, n)
{destination:
    - Batavia: 
        ~ return BataviaKnowledge(n)
    - Macau: 
        ~ return MacauKnowledge(n)
    - Labuan: 
        ~ return LabuanKnowledge(n)
}

=== function learn(destination, intel_type)
    ~ temp intel = knowledgeOf(destination, LIST_VALUE(intel_type))
    ~ Knowledge += intel

=== function know(destination, intel_type)
    ~ temp intel = knowledgeOf(destination, LIST_VALUE(intel_type))
    ~ return Knowledge ? intel

=== function maxknow(destination, intel_type)
    ~ temp intel = knowledgeOf(destination, LIST_VALUE(intel_type))
    

=== function verbose(obj) ===

{obj:
    - Food: des victuailles
    - Rum: du rhum
    - else : {obj}
    }
