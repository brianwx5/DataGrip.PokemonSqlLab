CREATE SCHEMA pokemon;

#What are all the types of pokemon that a pokemon can have?
SELECT DISTINCT types.name
FROM pokemon.types;

#What is the name of the pokemon with id 45?
SELECT pokemons.name
FROM pokemon.pokemons
WHERE id = 45;

#How many pokemon are there?
SELECT COUNT(*) AS 'Pokemon Count'
FROM pokemon.pokemons;

#How many pokemon have a secondary type?
SELECT COUNT(*)
FROM pokemon.pokemons
WHERE pokemons.secondary_type IS NOT NULL;

#What is each pokemon's primary type?
SELECT pokemons.name, types.name
FROM pokemon.pokemons,
     pokemon.types
WHERE pokemons.primary_type = types.id;

#What is Rufflet's secondary type?
SELECT pokemons.name, types.name
FROM pokemon.pokemons,
     pokemon.types
WHERE pokemons.secondary_type = types.id
  AND pokemons.name = "Rufflet";

#What are the names of the pokemon that belong to the trainer with trainerID 303?
SELECT pokemons.name
FROM pokemon.pokemons,
     pokemon.pokemon_trainer,
     pokemon.trainers
WHERE pokemons.id = pokemon_trainer.pokemon_id
  AND pokemon_trainer.trainerID = trainers.trainerID
  AND trainers.trainerID = 303;

#How many pokemon have a secondary type Poison
SELECT COUNT(pokemons.name)
FROM pokemon.pokemons,
     pokemon.types
WHERE pokemons.secondary_type = types.id
  AND types.name = "Poison";

#What are all the primary types and how many pokemon have that type?
SELECT types.name, COUNT(pokemons.name)
FROM pokemon.pokemons,
     pokemon.types
WHERE pokemons.primary_type = types.id
GROUP BY types.name;

#How many pokemon at level 100 does each trainer with at least one level 100 pokemone have? (Hint: your query should not display a trainer
SELECT pokemon_trainer.trainerID, COUNT(*)
FROM pokemon.pokemon_trainer
WHERE pokemon_trainer.pokelevel = 100
GROUP BY pokemon_trainer.trainerID;


#How many pokemon only belong to one trainer and no other?
SELECT COUNT(*)
FROM (SELECT COUNT(pokemon.pokemon_trainer.pokemon_id)
      FROM pokemon.pokemon_trainer
      GROUP BY pokemon_id
      HAVING COUNT(*) = 1) sub;


# Write a query that returns these columns Pokemon's Name, Trainer's Name, Level, Primary Type, Secondary Type
SELECT p.name      AS "Pokemon Name",
       trainername AS "Trainer Name",
       pokelevel   AS "Level",
       ty.name     AS "Primary Type",
       tys.name    AS "Secondary Type"
FROM pokemon.trainers AS t
       LEFT OUTER JOIN pokemon.pokemon_trainer as pt ON t.trainerID = pt.trainerID
       LEFT OUTER JOIN pokemon.pokemons AS p ON p.id = pt.pokemon_id
       LEFT OUTER JOIN pokemon.types AS ty ON p.primary_type = ty.id
       LEFT OUTER JOIN pokemon.types AS tys ON p.secondary_type = tys.id
        ORDER BY Level DESC,
          CASE WHEN `Primary Type` = 'Fairy' THEN 1
          END ASC;


# This is sorted by the strongest Level