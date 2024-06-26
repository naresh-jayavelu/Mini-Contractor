# Generated by Django 5.0 on 2023-12-13 10:33

import django.db.models.deletion
import uuid
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('role', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='address',
            fields=[
                ('addressLine1', models.CharField(blank=True, max_length=100)),
                ('addressLine2', models.CharField(blank=True, max_length=100)),
                ('pincode', models.CharField(blank=True, max_length=20)),
                ('state', models.CharField(blank=True, max_length=50)),
                ('country', models.CharField(blank=True, max_length=50)),
                ('latitude', models.CharField(blank=True, max_length=200)),
                ('longitude', models.CharField(blank=True, max_length=200)),
                ('isActive', models.BooleanField(default=True)),
                ('addressId', models.UUIDField(default=uuid.uuid4, primary_key=True, serialize=False)),
            ],
        ),
        migrations.CreateModel(
            name='documentType',
            fields=[
                ('documentTypeId', models.UUIDField(default=uuid.uuid4, primary_key=True, serialize=False)),
                ('code', models.CharField(blank=True, max_length=50)),
                ('name', models.CharField(blank=True, max_length=50)),
                ('discription', models.CharField(blank=True, max_length=50)),
                ('isActive', models.BooleanField(default=True)),
            ],
        ),
        migrations.CreateModel(
            name='expertise',
            fields=[
                ('expertiseCode', models.CharField(blank=True, max_length=50)),
                ('expertiseName', models.CharField(blank=True, max_length=50)),
                ('expertiseDescription', models.CharField(blank=True, max_length=200)),
                ('isActive', models.BooleanField(default=True)),
                ('expertiseId', models.UUIDField(default=uuid.uuid4, primary_key=True, serialize=False)),
            ],
        ),
        migrations.CreateModel(
            name='gender',
            fields=[
                ('genderCode', models.CharField(blank=True, max_length=50)),
                ('genderName', models.CharField(blank=True, max_length=50)),
                ('genderDescription', models.CharField(blank=True, max_length=200)),
                ('isActive', models.BooleanField(default=True)),
                ('genderId', models.UUIDField(default=uuid.uuid4, primary_key=True, serialize=False)),
            ],
        ),
        migrations.CreateModel(
            name='jobType',
            fields=[
                ('jobTypeCode', models.CharField(blank=True, max_length=50)),
                ('jobTypeName', models.CharField(blank=True, max_length=50)),
                ('jobTypeDescription', models.CharField(blank=True, max_length=200)),
                ('isActive', models.BooleanField(default=True)),
                ('jobTypeId', models.UUIDField(default=uuid.uuid4, primary_key=True, serialize=False)),
            ],
        ),
        migrations.AlterField(
            model_name='role',
            name='RoleDescription',
            field=models.CharField(blank=True, max_length=200),
        ),
        migrations.AlterField(
            model_name='role',
            name='id',
            field=models.UUIDField(default=uuid.uuid4, primary_key=True, serialize=False),
        ),
        migrations.CreateModel(
            name='contractorWorkProfile',
            fields=[
                ('contractorWorkProfileId', models.UUIDField(blank=True, default=uuid.uuid4, primary_key=True, serialize=False)),
                ('email', models.CharField(blank=True, max_length=50)),
                ('isActive', models.BooleanField(default=True)),
                ('roolId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='role.role')),
            ],
        ),
        migrations.CreateModel(
            name='document',
            fields=[
                ('documentId', models.UUIDField(default=uuid.uuid4, primary_key=True, serialize=False)),
                ('file', models.CharField(blank=True, max_length=200)),
                ('isActive', models.BooleanField(default=True)),
                ('documentTypeId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='role.documenttype')),
            ],
        ),
        migrations.CreateModel(
            name='user',
            fields=[
                ('userId', models.UUIDField(blank=True, default=uuid.uuid4, primary_key=True, serialize=False)),
                ('email', models.CharField(blank=True, max_length=50)),
                ('firstName', models.CharField(blank=True, max_length=50)),
                ('lastName', models.CharField(blank=True, max_length=50)),
                ('password', models.CharField(blank=True, max_length=50)),
                ('dob', models.CharField(blank=True, max_length=50)),
                ('phone', models.CharField(blank=True, max_length=50)),
                ('status', models.CharField(blank=True, max_length=50)),
                ('isActive', models.BooleanField(default=True)),
                ('addressId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='role.address')),
                ('genderId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='role.gender')),
                ('roolId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='role.role')),
            ],
        ),
    ]
