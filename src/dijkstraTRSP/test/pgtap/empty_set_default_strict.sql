\i setup.sql

SELECT plan(20);

----------------------------------------------------------------------------------------------------------------
-- testing from an existing starting vertex to a non-existing destination
----------------------------------------------------------------------------------------------------------------

-- in directed graph
-- with restrictions
PREPARE q1 AS
SELECT * FROM pgr_dijkstraTRSP(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table WHERE id = 4 OR id = 7',
    'SELECT * FROM restrict',
    2, 3
);

-- in undirected graph
-- with restrictions
PREPARE q2 AS
SELECT * FROM pgr_dijkstraTRSP(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table WHERE id = 4 OR id = 7',
    'SELECT * FROM restrict',
    2, 3,
    FALSE
);

-- in directed graph
-- without restrictions
PREPARE q3 AS
SELECT * FROM pgr_dijkstraTRSP(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table WHERE id = 4 OR id = 7',
    'SELECT * FROM restrict where id > 10',
    2, 3
);

-- in undirected graph
-- without restrictions
PREPARE q4 AS
SELECT * FROM pgr_dijkstraTRSP(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table WHERE id = 4 OR id = 7',
    'SELECT * FROM restrict where id > 10',
    2, 3,
    FALSE
);

----------------------------------------------------------------------------------------------------------------
-- testing from an non-existing starting vertex to an existing destination
----------------------------------------------------------------------------------------------------------------

-- in directed graph
-- with restrictions
PREPARE q5 AS
SELECT * FROM pgr_dijkstraTRSP(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table WHERE id = 4 OR id = 7',
    'SELECT * FROM restrict',
    6, 8
);

-- in undirected graph
-- with restrictions
PREPARE q6 AS
SELECT * FROM pgr_dijkstraTRSP(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table WHERE id = 4 OR id = 7',
    'SELECT * FROM restrict',
    6, 8,
    FALSE
);

-- in directed graph
-- without restrictions
PREPARE q7 AS
SELECT * FROM pgr_dijkstraTRSP(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table WHERE id = 4 OR id = 7',
    'SELECT * FROM restrict where id > 10',
    6, 8
);

-- in undirected graph
-- without restrictions
PREPARE q8 AS
SELECT * FROM pgr_dijkstraTRSP(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table WHERE id = 4 OR id = 7',
    'SELECT * FROM restrict where id > 10',
    6, 8,
    FALSE
);

----------------------------------------------------------------------------------------------------------------
-- testing from a non-existing starting vertex to a non-existing destination
----------------------------------------------------------------------------------------------------------------

-- in directed graph
-- with restrictions
PREPARE q9 AS
SELECT * FROM pgr_dijkstraTRSP(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table WHERE id = 4 OR id = 7',
    'SELECT * FROM restrict',
    1, 17
);

-- in undirected graph
-- with restrictions
PREPARE q10 AS
SELECT * FROM pgr_dijkstraTRSP(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table WHERE id = 4 OR id = 7',
    'SELECT * FROM restrict',
    1, 17,
    FALSE
);

-- in directed graph
-- without restrictions
PREPARE q11 AS
SELECT * FROM pgr_dijkstraTRSP(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table WHERE id = 4 OR id = 7',
    'SELECT * FROM restrict where id > 10',
    1, 17
);

-- in undirected graph
-- without restrictions
PREPARE q12 AS
SELECT * FROM pgr_dijkstraTRSP(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table WHERE id = 4 OR id = 7',
    'SELECT * FROM restrict where id > 10',
    1, 17,
    FALSE
);

----------------------------------------------------------------------------------------------------------------
-- testing from an existing starting vertex to the same destination
----------------------------------------------------------------------------------------------------------------

-- in directed graph
-- with restrictions
PREPARE q13 AS
SELECT * FROM pgr_dijkstraTRSP(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table WHERE id = 4 OR id = 7',
    'SELECT * FROM restrict',
    2, 2
);

-- in undirected graph
-- with restrictions
PREPARE q14 AS
SELECT * FROM pgr_dijkstraTRSP(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table WHERE id = 4 OR id = 7',
    'SELECT * FROM restrict',
    2, 2,
    FALSE
);

-- in directed graph
-- without restrictions
PREPARE q15 AS
SELECT * FROM pgr_dijkstraTRSP(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table WHERE id = 4 OR id = 7',
    'SELECT * FROM restrict where id > 10',
    2, 2
);

-- in undirected graph
-- without restrictions
PREPARE q16 AS
SELECT * FROM pgr_dijkstraTRSP(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table WHERE id = 4 OR id = 7',
    'SELECT * FROM restrict where id > 10',
    2, 2,
    FALSE
);

----------------------------------------------------------------------------------------------------------------
-- testing from an existing starting vertex in one component to an existing destination in another component
----------------------------------------------------------------------------------------------------------------
-- in directed graph
-- with restrictions
PREPARE q17 AS
SELECT * FROM pgr_dijkstraTRSP(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table WHERE id IN (4, 7, 17)',
    'SELECT * FROM restrict',
    2, 14
);

-- in undirected graph
-- with restrictions
PREPARE q18 AS
SELECT * FROM pgr_dijkstraTRSP(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table WHERE id IN (4, 7, 17)',
    'SELECT * FROM restrict',
    2, 14,
    FALSE
);

-- in directed graph
-- without restrictions
PREPARE q19 AS
SELECT * FROM pgr_dijkstraTRSP(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table WHERE id IN (4, 7, 17)',
    'SELECT * FROM restrict where id > 10',
    2, 14
);

-- in undirected graph
-- without restrictions
PREPARE q20 AS
SELECT * FROM pgr_dijkstraTRSP(
    'SELECT id, source, target, cost, reverse_cost FROM edge_table WHERE id IN (4, 7, 17)',
    'SELECT * FROM restrict where id > 10',
    2, 14,
    FALSE
);

----------------------------------------------------------------------------------------------------------------

SELECT is_empty('q1');
SELECT is_empty('q2');
SELECT is_empty('q3');
SELECT is_empty('q4');
SELECT is_empty('q5');
SELECT is_empty('q6');
SELECT is_empty('q7');
SELECT is_empty('q8');
SELECT is_empty('q9');
SELECT is_empty('q10');
SELECT is_empty('q11');
SELECT is_empty('q12');
SELECT is_empty('q13');
SELECT is_empty('q14');
SELECT is_empty('q15');
SELECT is_empty('q16');
SELECT is_empty('q17');
SELECT is_empty('q18');
SELECT is_empty('q19');
SELECT is_empty('q20');

SELECT * FROM finish();
ROLLBACK;
