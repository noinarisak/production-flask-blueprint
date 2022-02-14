from flask import current_app
from flask_mail import Message

from . import celery, mail


@celery.task(name="app.tasks.send_celery_email")
def send_celery_email(message_data):
    app = current_app._get_current_object()
    message = Message(
        subject=message_data["subject"],
        recipients=[message_data["recipients"]],
        body=message_data["body"],
        sender=app.config["MAIL_DEFAULT_SENDER"],
    )

    with app.app_context():
        mail.send(message)
