# Generated by Django 4.2.7 on 2023-12-25 15:47

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('role', '0007_alter_document_file'),
    ]

    operations = [
        migrations.AlterField(
            model_name='document',
            name='documentTypeId',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='role.documenttype'),
        ),
    ]
