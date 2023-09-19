let initialized = false;

try {
    rs.status().ok;
    initialized = true;
} catch (e) {
    print("Not yet initialized")
}

if (!initialized) {
    print("Run initialization")
    config = {
        "_id": process.env.SHARD_NAME,
        "members": [
            {
                "_id": 0,
                "host": process.env.HOST+":27000"
            },
            {
                "_id": 1,
                "host": process.env.HOST+":27001"
            },
            {
                "_id": 2,
                "host": process.env.HOST+":27002"
            }
        ]
    };
    rs.initiate(config);
}
