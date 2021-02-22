const express = require('express')
const app = express()

app.get('/', (req, res) => res.send('Welcome to EKS on Fargate!'))
app.listen(3000, () => console.log('Server ready'))
