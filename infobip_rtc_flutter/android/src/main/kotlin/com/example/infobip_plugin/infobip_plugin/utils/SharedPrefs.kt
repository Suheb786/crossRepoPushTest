package com.example.infobip_plugin.infobip_plugin.utils

import android.content.Context
import android.content.SharedPreferences

object SharedPrefs {

    /**
     * SharedPreferences file name
     */
    private const val SHARED_PREFS_FILE_NAME = "Infobip_plugin"

    /**
     * Initialize SharedPreferences
     */
    fun getPrefs(context: Context): SharedPreferences {
        return context.getSharedPreferences(SHARED_PREFS_FILE_NAME, Context.MODE_PRIVATE)
    }

    /**
     * Find contain value of SharedPreferences key
     */
    fun contain(context: Context, key: String): Boolean {
        return getPrefs(context).contains(key)
    }

    /**
     * Clear SharedPreferences value of particular key
     */
    fun clearPrefs(context: Context,key: String) {
        val data = getString(context, key)
        getPrefs(context).edit().remove(key).apply()
        save(context, key, data)
    }

    /**
     * Save boolean value
     */
    fun savePref(context: Context, key: String, value: Boolean) {
        getPrefs(context).edit().putBoolean(key, value).apply()
    }

    /**
     * Get boolean value
     */
    fun getBoolean(context: Context, key: String): Boolean {
        return getPrefs(context).getBoolean(key, false)
    }

    /**
     * If boolean value not get than given default value
     */
    fun getBoolean(context: Context, key: String, defaultValue: Boolean): Boolean {
        return getPrefs(context).getBoolean(key, defaultValue)
    }

    /**
     * Save string value
     */
    fun save(context: Context, key: String, value: String) {
        getPrefs(context).edit().putString(key, value).apply()
    }

    /**
     * Get string value
     */
    fun getString(context: Context, key: String): String {
        return getPrefs(context).getString(key, "")!!
    }

    /**
     * If string value not get than given default value
     */
    fun getString(context: Context, key: String, defaultValue: String): String {
        return getPrefs(context).getString(key, defaultValue)!!
    }

    /**
     * Save integer value
     */
    fun save(context: Context, key: String, value: Int) {
        getPrefs(context).edit().putInt(key, value).apply()
    }

    /**
     * Get integer value
     */
    fun getInt(context: Context, key: String): Int {
        return getPrefs(context).getInt(key, 0)
    }

    /**
     * If integer value not get than given default value
     */
    fun getInt(context: Context, key: String, defaultValue: Int): Int {
        return getPrefs(context).getInt(key, defaultValue)
    }

    /**
     * Save float value
     */
    fun save(context: Context, key: String, value: Float) {
        getPrefs(context).edit().putFloat(key, value).apply()
    }

    /**
     * Get float value
     */
    fun getFloat(context: Context, key: String): Float {
        return getPrefs(context).getFloat(key, 0f)
    }

    /**
     * If float value not get than given default value
     */
    fun getFloat(context: Context, key: String, defaultValue: Float): Float {
        return getPrefs(context).getFloat(key, defaultValue)
    }

    /**
     * Save long value
     */
    fun save(context: Context, key: String, value: Long) {
        getPrefs(context).edit().putLong(key, value).apply()
    }

    /**
     * Get long value
     */
    fun getLong(context: Context, key: String): Long {
        return getPrefs(context).getLong(key, 0)
    }

    /**
     * If long value not get than given default value
     */
    fun getLong(context: Context, key: String, defaultValue: Long): Long {
        return getPrefs(context).getLong(key, defaultValue)
    }

    /**
     * Remove value of particular key
     */
    fun removeKey(context: Context, key: String) {
        getPrefs(context).edit().remove(key).apply()
    }
}
