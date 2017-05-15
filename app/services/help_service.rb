class HelpService
  def initialize(params);  end;

  def call
    response = "*What can I do :raised_hands:* \n\n"
    response += "*help*\n"
    response += ">I know the following commands:\n\n"
    response += "*Add to FAQ*\n"
    response += ">Add a new question to FAQ\n\n"
    response += "*Remove ID*\n"
    response += ">Remove a question based on the FAQ's ID\n\n"
    response += "*What do you know about X*\n"
    response += ">Search for a given word in the questions and answers list\n\n"
    response += "*Search for hashtag X*\n"
    response += ">Lists questions and answers about the given hashtag\n\n"
    response += "*Questions and Answers*\n"
    response += ">Show the Questions and Answers list\n\n"
  end
end
