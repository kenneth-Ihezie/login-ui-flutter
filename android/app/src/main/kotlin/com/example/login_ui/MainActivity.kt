package com.example.login_ui

import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle
import android.provider.MediaStore
import java.util.*
import androidx.annotation.NonNull
import android.Manifest
import android.os.Build
import android.app.Activity
import android.util.Log



class MainActivity: FlutterActivity() {
    //Make sure to use the same channel name as was used on the Flutter client side.
    private val CHANNEl = "samples.flutter.dev/camera"
    private lateinit var result: String
    companion object{
        const val IMAGE_PICK_CODE = 1000
        const val REQUEST_TAKE_PHOTO = 3
        const val PERMISSION_CODE = 1001
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEl).setMethodCallHandler {
            // Note: this method is invoked on the main thread.
            call, result ->
            if (call.method == "startCamera") {
                val camera = startCamera()
            } else {
                result.notImplemented()
            }
        }
    }





    private fun startCamera(): String{
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M){
            if (checkSelfPermission(Manifest.permission.READ_EXTERNAL_STORAGE) ==
                    PackageManager.PERMISSION_DENIED){
                val permissions = arrayOf(Manifest.permission.READ_EXTERNAL_STORAGE)
                requestPermissions(permissions, PERMISSION_CODE)
            }
            else{
                pickImageFromGallery()
                camera()
            }
        }
        else{
            pickImageFromGallery()
            camera()
        }
        Log.d("tag", "${result}")
        return result
    }


    private fun pickImageFromGallery(){
        val intent = Intent(Intent.ACTION_PICK)
        intent.type = "image/*"
        startActivityForResult(intent, IMAGE_PICK_CODE)
    }

    private fun camera(){
        val intent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
        startActivityForResult(intent, REQUEST_TAKE_PHOTO)
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        when(requestCode){
            PERMISSION_CODE -> {
                if (grantResults.isNotEmpty() && grantResults[0] ==
                        PackageManager.PERMISSION_GRANTED){
                    pickImageFromGallery()
                }
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == Activity.RESULT_OK && requestCode == IMAGE_PICK_CODE){
            result = data!!.toString()
        }
    }
}
