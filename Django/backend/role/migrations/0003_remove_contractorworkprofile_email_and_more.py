# Generated by Django 5.0 on 2023-12-13 11:31

import django.db.models.deletion
import uuid
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('role', '0002_address_documenttype_expertise_gender_jobtype_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='contractorworkprofile',
            name='email',
        ),
        migrations.RemoveField(
            model_name='contractorworkprofile',
            name='roolId',
        ),
        migrations.AlterField(
            model_name='document',
            name='documentTypeId',
            field=models.ForeignKey(blank=True, on_delete=django.db.models.deletion.CASCADE, to='role.documenttype'),
        ),
        migrations.AlterField(
            model_name='user',
            name='addressId',
            field=models.ForeignKey(blank=True, on_delete=django.db.models.deletion.CASCADE, to='role.address'),
        ),
        migrations.AlterField(
            model_name='user',
            name='genderId',
            field=models.ForeignKey(blank=True, on_delete=django.db.models.deletion.CASCADE, to='role.gender'),
        ),
        migrations.AlterField(
            model_name='user',
            name='roolId',
            field=models.ForeignKey(blank=True, on_delete=django.db.models.deletion.CASCADE, to='role.role'),
        ),
        migrations.CreateModel(
            name='documentMapping',
            fields=[
                ('documentMappingId', models.UUIDField(blank=True, default=uuid.uuid4, primary_key=True, serialize=False)),
                ('isActive', models.BooleanField(default=True)),
                ('documentId', models.ForeignKey(blank=True, on_delete=django.db.models.deletion.CASCADE, to='role.document')),
                ('entityId', models.ForeignKey(blank=True, on_delete=django.db.models.deletion.CASCADE, to='role.user')),
                ('entityType', models.ForeignKey(blank=True, on_delete=django.db.models.deletion.CASCADE, to='role.role')),
            ],
        ),
    ]
