from flask import render_template

from ..tasks import send_celery_email
from . import auth_blueprint


@auth_blueprint.route("/register/<string:email>")
def register(email):
    message_data = {
        "subject": "Hello from the flask app!",
        "body": "This email was sent asynchronously using Celery.",
        "recipients": email,
    }
    send_celery_email.apply_async(args=[message_data])
    return render_template("auth/register.html", email=email)
