# Generated by Django 5.0 on 2024-03-06 07:29

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('role', '0017_message_time'),
    ]

    operations = [
        migrations.RenameField(
            model_name='message',
            old_name='time',
            new_name='time2',
        ),
    ]
