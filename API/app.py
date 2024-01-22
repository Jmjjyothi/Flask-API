from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
import uuid

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///messages.db'  # SQLite for simplicity
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)


class Message(db.Model):
    id = db.Column(db.String(36), primary_key=True)
    account_id = db.Column(db.String(50), nullable=False)
    sender_number = db.Column(db.String(15), nullable=False)
    receiver_number = db.Column(db.String(15), nullable=False)


@app.route('/get/messages/<account_id>', methods=['GET'])
def get_messages(account_id):
    messages = Message.query.filter_by(account_id=account_id).all()
    result = [{
        'message_id': msg.id,
        'account_id': msg.account_id,
        'sender_number': msg.sender_number,
        'receiver_number': msg.receiver_number
    } for msg in messages]
    return jsonify(result)


@app.route('/create', methods=['POST'])
def create_message():
    data = request.json
    message = Message(
        id=str(uuid.uuid4()),
        account_id=data['account_id'],
        sender_number=data['sender_number'],
        receiver_number=data['receiver_number']
    )
    db.session.add(message)
    db.session.commit()
    return jsonify({'message_id': message.id}), 201


@app.route('/search', methods=['GET'])
def search_messages():
    filters = request.args.to_dict()
    messages = Message.query.filter_by(**filters).all()
    result = [{
        'message_id': msg.id,
        'account_id': msg.account_id,
        'sender_number': msg.sender_number,
        'receiver_number': msg.receiver_number
    } for msg in messages]
    return jsonify(result)


if __name__ == "__main__":
    with app.app_context():
        db.create_all()
        app.run()
