# Django
function pmm(){
    python manage.py makemigrations
    python manage.py migrate
}

function pmmr(){
    python manage.py makemigrations
    python manage.py migrate
    python manage.py runserver
}


alias pr='python manage.py runserver'

alias psu='python manage.py createsuperuser'
