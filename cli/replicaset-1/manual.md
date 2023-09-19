

Start mongos
```bash
mongos -f files/mongos.yaml
```

Add shards to cluster

```js
sh.addShard("rs1/localhost:27010,localhost:27011,localhost:27012")
sh.addShard("rs2/localhost:27020,localhost:27021,localhost:27022")
```
