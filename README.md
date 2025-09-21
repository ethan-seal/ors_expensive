# ORs are Expensive Example

This is an example showing how queries with ORs (despite `BitmapOr`) can be quite expensive.

Rewriting an aggregate query with an OR clause into multiple aggregate queries using only `AND`s is much faster at scale.

On my machine (AMD Ryzen 5 7600X, 32GB memory, Samsung 990 Pro 2TB, Arch Linux 6.18.8, PostgreSQL 17.5), I get the following results:

|      |   OR   |  AND  |
|------|--------|-------|
|Cold  | 136.3ms|  0.9ms|
|Cached|   1.7ms|  0.7ms|

Raw:
```
Evicting OS cache
Evicting Postgres shared cache
Running ors
Timing is on.
 count
-------
  2022
(1 row)

Time: 136.323 ms
Running ors
Timing is on.
 count
-------
  2022
(1 row)

Time: 1.737 ms
Evicting OS cache
Evicting Postgres shared cache
Running ands
Timing is on.
 ?column?
----------
     2022
(1 row)

Time: 0.889 ms
Running ands
Timing is on.
 ?column?
----------
     2022
(1 row)

Time: 0.695 ms
```
