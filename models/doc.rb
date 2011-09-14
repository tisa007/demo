class Doc
    include DataMapper::Resource

    property :id, Serial
    property :title, String
    property :body, Text
    property :create_at, DateTime

end
