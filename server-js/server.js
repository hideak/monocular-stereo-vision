const io = require('socket.io')(3000);

io.on('connection', socket => {
  console.log('Client Connected!');
  
  socket.on('accX', data => {
    console.log(data);
  });

  socket.on('accY', data => {
    console.log(data);
  });

  socket.on('accZ', data => {
    console.log(data);
  });

  socket.on('angAccX', data => {
    console.log(data);
  });

  socket.on('angAccY', data => {
    console.log(data);
  });

  socket.on('angAccZ', data => {
    console.log(data);
  });
});
