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
        "_id": 'repl-1',
        "members": [
            {
                "_id": 0,
                "host": "gen-docker25246-all-dev.antispy.e5.c.emag.network:27017"
            },
            {
                "_id": 1,
                "host": "gen-docker13053-all-dev.antispy.e5.c.emag.network:27017"
            },
            {
                "_id": 2,
                "host": "gen-docker17116-all-dev.antispy.e5.c.emag.network:27017"
            }
        ]
    };
    rs.initiate(config);
}
