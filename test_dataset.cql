CREATE CONSTRAINT ON (u:User) ASSERT c.user_id IS UNIQUE;
CREATE CONSTRAINT ON (e:Entry) ASSERT e.page IS UNIQUE;

CREATE (u:User { id : 9})
SET u.date = 1550177684,
    u.device = 'Desktop',
    u.gender  = 'Male'

CREATE (u:User { id : 10})
SET u.date = 1550177584,
    u.device = 'Mobile',
    u.gender = 'Male'

CREATE (u:User { id : 7})
SET u.date = 1550177587,
    u.device = 'Mobile',
    u.gender = 'Female'

CREATE (u:User { id : 8})
SET u.date = 1550177587,
    u.device = 'Desktop',
    u.gender ='Female'


MATCH (u:User { id : 1}), (e:Entry { page : 'home_page'})
MERGE (u)-[r:VISITED]->(e)
    ON MATCH SET r.visited_count = r.visited_count + 1
    ON CREATE SET r.visited_count = 1
