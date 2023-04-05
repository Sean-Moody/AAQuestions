require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
include Singleton
    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end

class User
    attr_accessor :fname, :lname, :id

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
        #@lname = options['lname'] alternate notation
    end

    def self.find_by_id(id)
        user = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT  
                *
            FROM
                users
            WHERE
                id = ?;
        SQL
        User.new(user.first)
    end
end

class Question
    attr_accessor :id, :title, :body, :author_id

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id) 
        SELECT  
            *
        FROM
            questions
        WHERE
            id = ?;
    SQL
        Question.new(question.first)
    end

    def self.find_by_author_id(author_id)
        question = QuestionsDatabase.instance.execute(<<-SQL, author_id)
        SELECT
            *
        FROM
            questions
        WHERE
            author_id = ?;
        SQL
        Question.new(question.first)
    end

end

class Question_Follow
    attr_accessor :id, :user_id, :question_id

    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
    end

    def self.find_by_id(id)
        question_follow = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT  
            *
        FROM
            question_follows
        WHERE
            id = ?;
    SQL
        Question_Follow.new(question_follow.first)
    end


end

class Reply
    attr_accessor :id, :question_id, :parent_reply_id, :reply_author_id, :body

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @parent_reply_id = options['parent_reply_id']
        @reply_author_id = options['reply_author_id']
        @body = options['body']
    end

    def self.find_by_id(id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT  
            *
        FROM
            replies
        WHERE
            id = ?;
    SQL
        Reply.new(reply.first)
    end

end

class Question_Like
    attr_accessor :id, :liked_question, :liker

    def initialize(options)
        @id = options['id']
        @liked_question = options['liked_question']
        @liker = options['liker']
    end

    def self.find_by_id(id)
        question_like = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT  
            *
        FROM
            question_likes
        WHERE
            id = ?;
    SQL

        Question_Like.new(question_like.first)
    end

end