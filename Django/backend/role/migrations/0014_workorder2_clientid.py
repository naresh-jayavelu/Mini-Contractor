# Generated by Django 5.0 on 2024-03-04 12:25

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('role', '0013_alter_document_file'),
    ]

    operations = [
        migrations.AddField(
            model_name='workorder2',
            name='clientId',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='role.user'),
        ),
    ]
