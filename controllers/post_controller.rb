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
    title: "Harry Potter and the Philosophers stone",
    author: "J. K. Rowling",
    year_released: "26 Jun 1997",
    description: "Harry Potter: The boy who lived. 1st year at Hogwarts certainly didn't go as planned."
   },
   {
     id: 1,
     title: "Stormbreaker",
     author: "Anthony Horowitz",
     year_released: "4 Sept 2000",
     description: "After his uncle is killed in an 'accident', Alex Rider takes his place as an MI6 agent, poised to stop codename: Stormbreaker."
   },
   {
     id: 2,
     title: "IT",
     author: "Stephen King",
     year_released: "15 Sept 1986",
     description: "In the storm drains, in the sewers, IT lurks, taking the shape of every nightmare for every person in the small town of Derry."
   },
   {
     id: 3,
     title: "Lord of the Flies",
     author: "William Golding",
     year_released: "17 Sept 1954",
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
    erb :"posts/new"
   end

   # POST request of new form
    post "/" do
      new_post = {
        id: $books.length,
        title: params[:title],
        author: params[:author],
        year_released: params[:year_released],
        description: params[:description]
      }

      $books.push(new_post)
      redirect "/books"
   end

   # Get 'Edit entry' form
   get "/books/:id/edit" do
     erb :"posts/edit"
   end

   # PUT request of edit form
   put "/:id" do
     "Book updated"
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
