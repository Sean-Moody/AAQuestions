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

    def find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT  
            *
        FROM
            questions
        WHERE
            id = ?;
    SQL
    end

end

class Question_Follow
    attr_accessor :id, :user_id, :question_id

    def find_by_id(id)
        question_follow = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT  
            *
        FROM
            question_follows
        WHERE
            id = ?;
    SQL
    end


end

class Reply
    attr_accessor :id, :question_id, :parent_reply_id, :reply_author_id, :body

    def find_by_id(id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT  
            *
        FROM
            replies
        WHERE
            id = ?;
    SQL
    end

end

class Question_Like
    attr_accessor :id, :liked_question, :liker

    def find_by_id(id)
        question_like = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT  
            *
        FROM
            question_likes
        WHERE
            id = ?;
    SQL
    end

end