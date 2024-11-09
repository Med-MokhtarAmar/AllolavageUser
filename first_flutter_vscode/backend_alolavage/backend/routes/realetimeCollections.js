// const mongoose = require('mongoose');

// // Connect to MongoDB
// mongoose.connect('mongodb://localhost:27017/mersoly', {
//   useNewUrlParser: true,
//   useUnifiedTopology: true,
// });

// // Create a change stream after the connection is open
// mongoose.connection.once('open', () => {
//   console.log('MongoDB connection established.');

//   // Get the collection
//   const coursCollection = mongoose.connection.collection('cours');

//   // Start watching for changes
//   const changeStream = coursCollection.watch();

//   changeStream.on('change', (change) => {
//     console.log('Change detected:', change);
//     // Handle the change event (e.g., notify clients, process the change, etc.)
//   });
// });

// // Handle connection errors
// mongoose.connection.on('error', (err) => {
//   console.error('MongoDB connection error:', err);
// });
