class PostController < Sinatra::Base

  # Set the root of the controller
  set :root, File.join(File.dirname(__FILE__), "..")
  # Set where to find the views on the controller
  set :views, Proc.new { File.join(root, "views") }

   # Starts the Sinatra reloader
   configure :development do
     register Sinatra::Reloader
   end

   # Temporary data storage (Hash array) for default posts
   $books = [{
    id: 0,
    img_url: "https://media.bloomsbury.com/rep/bj/9780747532699.jpg",
    title: "Harry Potter and the Philosophers stone",
    author: "J. K. Rowling",
    year_released: "1997",
    description: "Harry Potter: The boy who lived. 1st year at Hogwarts certainly didn't go as planned."
   },
   {
     id: 1,
     img_url: "https://upload.wikimedia.org/wikipedia/en/thumb/1/1c/Stormbreakerbook.jpg/220px-Stormbreakerbook.jpg",
     title: "Stormbreaker",
     author: "Anthony Horowitz",
     year_released: "2000",
     description: "After his uncle is killed in an 'accident', Alex Rider takes his place as an MI6 agent, poised to stop codename: Stormbreaker."
   },
   {
     id: 2,
     title: "IT",
     img_url: "https://images-na.ssl-images-amazon.com/images/I/5123BkxEJ3L._SX324_BO1,204,203,200_.jpg",
     author: "Stephen King",
     year_released: "1986",
     description: "In the storm drains, in the sewers, IT lurks, taking the shape of every nightmare for every person in the small town of Derry."
   },
   {
     id: 3,
     img_url: "https://images-na.ssl-images-amazon.com/images/I/51KsgCsIYyL._SX315_BO1,204,203,200_.jpg",
     title: "Lord of the Flies",
     author: "William Golding",
     year_released: "1954",
     description: "A plan crashes on a desert island and the only survirors, a group of school boys, assemble on the beach and wait to be rescued."
   }]

   # Root request
   get "/" do
     @title = "Home"
     erb :"posts/index"
   end

   # All request
   get "/books" do
     @title = "All books"
     @books = $books
     erb :"posts/show_all"
   end

   # Get 'Create New' form
   get "/books/new" do
     @title = "Add book"
     # Assign the book_info object for use in the html
     @book_info = {
       id: "",
       title: "",
       author: "",
       year_released: "",
       description: ""
     }
    erb :"posts/new"
   end

   # POST request of new form
    post "/" do
      # Get the information that the user submitted
      new_post = {
        id: $books.length,
        title: params[:title],
        author: params[:author],
        year_released: params[:year_released],
        description: params[:description]
      }
      # Add the information to the array
      $books.push(new_post)
      # Redirect back to the books list
      redirect "/books"
   end

   # Get 'Edit entry' form
   get "/books/:id/edit" do
     @title = "Edit book"
     # Get the id from the parameters
     id = params[:id].to_i
     # Get the specific object from the books array using the array from the browser
     @book = $books[id]
     @book_info = {
       id: @book[:id],
       title: @book[:title],
       author: @book[:author],
       year_released: @book[:year_released],
       description: @book[:description]
     }
     erb :"posts/edit"
   end

   # PUT request of edit form
   put "/:id" do
     id = params[:id].to_i
     @book = $books[id]
     # Update the record
     @book[:title] = params[:title]
     @book[:author] = params[:author]
     @book[:year_released] = params[:year_released]
     @book[:description] = params[:description]

     $books[id] = @book

     redirect "/books"
   end

   # DELETE Entry
   delete "/:id" do
     id = params[:id].to_i
     # Get the id and delete at this index
     $books.delete_at(id)
     redirect "/books"
   end

   # One request
   get "/books/:id" do
     id = params[:id].to_i
     @book = $books[id]
     @title = @book[:title]
     erb :"posts/show_one"
   end

end
