from flask import Flask, request, jsonify
import spacy
import numpy as np 

# Load the spaCy model
nlp = spacy.load("en_core_web_md")

# Define the perfect answer vectors for previous positions, aptitude, volunteering experiences, and what would you do differently
perfect_previous_positions_answer = nlp("Previous positions held: IEEE Web Lead, CSI Web Lead, and GDSC Web Lead. Managed website functionality, security, and user experience. Led teams in development and optimization, gaining valuable web development and leadership skills.").vector
perfect_aptitude_answer = nlp("I am highly capable for this position due to my strong leadership skills and extensive experience in managing web development projects. As a web lead for IEEE, CSI, and GDSC, I have successfully managed website functionality, security, and user experience. I am adept at leading teams in development and optimization, and I am eager to contribute these skills to your team.").vector
perfect_volunteering_experiences_answer = nlp("I have actively participated in various web development projects, including my involvement in the Asthra web team where I contributed to the creation of event websites. Additionally, I have dedicated my efforts to supporting initiatives within the IEEE Kerala section, notably contributing to events like AKSC. Through these experiences, I have honed my skills in web development, teamwork, and project management, while also demonstrating a commitment to community and professional development.").vector
perfect_what_would_you_do_differently_answer = nlp("If chosen for the web team, I'd prioritize teamwork and innovation. I'd encourage regular brainstorming sessions, adopt agile methodologies for efficiency, and organize skill-sharing workshops. Communication would be transparent, with regular updates and feedback sessions. Seeking input from stakeholders and users would ensure our work meets their needs. Overall, I'd foster a culture of collaboration, continuous learning, and user-centricity for exceptional results.").vector

app = Flask(__name__)

# Variables to store inputs temporarily
previous_positions_input = None
aptitude_input = None
volunteering_experiences_input = None
what_would_you_do_differently_input = None

@app.route('/submit', methods=['POST'])
def submit():
    global previous_positions_input, aptitude_input, volunteering_experiences_input, what_would_you_do_differently_input

    data = request.json
    print("Raw input data:", data)  # Debugging statement to print raw input data
    previous_positions = data.get('previous_positions')
    aptitude = data.get('aptitude')
    volunteering_experiences = data.get('volunteering_experiences')
    what_would_you_do_differently = data.get('what_would_you_do_differently')

    # If previous positions input is received
    if previous_positions is not None:
                previous_positions_input = previous_positions

    # If aptitude input is received
    if aptitude is not None:
        aptitude_input = aptitude

    # If volunteering experiences input is received
    if volunteering_experiences is not None:
        volunteering_experiences_input = volunteering_experiences

    # If what would you do differently input is received
    if what_would_you_do_differently is not None:
        what_would_you_do_differently_input = what_would_you_do_differently

    # If all inputs are received, calculate scores
    if (previous_positions_input is not None and aptitude_input is not None 
        and volunteering_experiences_input is not None and what_would_you_do_differently_input is not None):

        # Process input sentences and obtain word vectors
        previous_positions_vector = nlp(previous_positions_input).vector
        aptitude_vector = nlp(aptitude_input).vector
        volunteering_experiences_vector = nlp(volunteering_experiences_input).vector
        what_would_you_do_differently_vector = nlp(what_would_you_do_differently_input).vector


        # Calculate cosine similarity between user input vectors and perfect answer vectors
        previous_positions_similarity = np.dot(previous_positions_vector, perfect_previous_positions_answer) / (np.linalg.norm(previous_positions_vector) * np.linalg.norm(perfect_previous_positions_answer))
        aptitude_similarity = np.dot(aptitude_vector, perfect_aptitude_answer) / (np.linalg.norm(aptitude_vector) * np.linalg.norm(perfect_aptitude_answer))
        volunteering_experiences_similarity = np.dot(volunteering_experiences_vector, perfect_volunteering_experiences_answer) / (np.linalg.norm(volunteering_experiences_vector) * np.linalg.norm(perfect_volunteering_experiences_answer))
        what_would_you_do_differently_similarity = np.dot(what_would_you_do_differently_vector, perfect_what_would_you_do_differently_answer) / (np.linalg.norm(what_would_you_do_differently_vector) * np.linalg.norm(perfect_what_would_you_do_differently_answer))

        # Scale the similarity scores to a range of 0 to 100
        previous_positions_score = round(previous_positions_similarity * 100)
        aptitude_score = round(aptitude_similarity * 100)
        volunteering_experiences_score = round(volunteering_experiences_similarity * 100)
        what_would_you_do_differently_score = round(what_would_you_do_differently_similarity * 100)

        # Calculate the average score
        average_score = round((previous_positions_score + aptitude_score + volunteering_experiences_score + what_would_you_do_differently_score) / 4)

        # Print similarity scores for debugging
        print('Previous positions similarity:', previous_positions_score)
        print('Aptitude similarity:', aptitude_score)
        print('Volunteering experiences similarity:', volunteering_experiences_score)
        print('What would you do differently similarity:', what_would_you_do_differently_score)
        print('Average score:', average_score)

        # Reset the temporary input variables for future requests
        previous_positions_input = None
        aptitude_input = None
        volunteering_experiences_input = None
        what_would_you_do_differently_input = None

        # Construct JSON response with scores and success message
        response_data = {
            'previous_positions_score': previous_positions_score,
            'aptitude_score': aptitude_score,
            'volunteering_experiences_score': volunteering_experiences_score,
            'what_would_you_do_differently_score': what_would_you_do_differently_score,
            'average_score': average_score,
            'message': 'Data received and processed successfully'
        }

        return jsonify(response_data)

    # If only one or some inputs are received, return a success message
    return jsonify({'message': 'Input received successfully'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)


