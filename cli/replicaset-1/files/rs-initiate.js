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
        "_id": process.env.RS_NAME,
        "members": [
            {
                "_id": 0,
                "host": process.env.HOSTNAME + ":" + parseInt(process.env.RS_PORT)
            },
            {
                "_id": 1,
                "host": process.env.HOSTNAME + ":" + (parseInt(process.env.RS_PORT) + 1)
            },
            {
                "_id": 2,
                "host": process.env.HOSTNAME + ":" + (parseInt(process.env.RS_PORT) + 2)
            }
        ]
    };
    rs.initiate(config);
}
