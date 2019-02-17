// List user's who are Male
MATCH (u:User { gender : 'Male'}) RETURN u

// List user's who are Female
MATCH (u:User { gender : 'Female'}) RETURN u

// List User's who are `Male` and used `mobile` device
MATCH (u:User { gender : 'Male', platform : 'Mobile'}) RETURN u

// Total count of User's who are `Male` and used `mobile` platform
MATCH (u:User { gender : 'Male', platform : 'Mobile'}) RETURN count(u)

// Group user's by gender and take it's count
MATCH (u:User) RETURN u.gender AS gender, count(u) AS total

// Group user's by device and take it's count
MATCH (u:User) RETURN u.device AS device, u.gender as gender, count(u) AS total ORDER BY count(u) DESC




