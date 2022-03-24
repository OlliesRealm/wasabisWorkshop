from django.contrib import admin

from .models import User


@admin.register(User)
class ArtistAdmin(admin.ModelAdmin):
    list_display = ['email', 'username']


# from .models import User


# @admin.register(User)
# class ArtistAdmin(admin.ModelAdmin):
#     list_display = ['username']


# Register your models here.