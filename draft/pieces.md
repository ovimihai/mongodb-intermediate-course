

___

Other collection import
```js
sh.enableSharding('test')
sh.shardCollection('test.people', {_id:1})
```
```bash
mongoimport --port 26000 -d test -c people people.json
```

```js
sh.status()
```
___

