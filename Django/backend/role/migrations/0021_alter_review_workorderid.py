# Generated by Django 5.0 on 2024-03-11 07:41

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('role', '0020_alter_message_time2'),
    ]

    operations = [
        migrations.AlterField(
            model_name='review',
            name='workOrderId',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='role.workorder2'),
        ),
    ]