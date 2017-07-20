package com.maryun.utils;

import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

/**
 * 
 * @ClassName: FilesSaveLocalUtils 
 * @Description: 文件保存到本地的工具类,所有方法返回boolean，true成功，false失败
 * @author SR 
 * @date 2017年3月18日
 */
@Service
public class FilesSaveLocalUtils {
	
	/**
	 * 
	 * @Description: 存入文件到指定地址
	 * @param multipartFile 传入的文件
	 * @param filePath 存储的地址
	 * @return
	 */
	public boolean savePhotoToPath(MultipartFile multipartFile,String filePath){
		BufferedOutputStream bos=null;
        try
        {
            bos = new BufferedOutputStream(new FileOutputStream(filePath));
            byte[] bytes = multipartFile.getBytes();
            bos.write(bytes);
            bos.flush();
        } catch (Exception e) {
			e.printStackTrace();
			return false;
		}
        finally
        {
            if (bos != null)
				try {
					bos.close();
				} catch (IOException e) {
					e.printStackTrace();
					return false;
				}
        }
		return true;
	}
	
	/**
	 * 
	 * @Description: 存入文件到指定地址
	 * @param file 传入的文件
	 * @param filePath 存储的地址
	 * @return
	 */
	public boolean savePhotoToPath(File file,String filePath){
		BufferedOutputStream bos=null;
		//获得file的bytes
		
		byte[] buffer = null;  
	    try  
	      {   
	        FileInputStream fis = new FileInputStream(file);  
	        ByteArrayOutputStream bos1 = new ByteArrayOutputStream();  
	        byte[] b = new byte[1024];  
	        int n;  
	        while ((n = fis.read(b)) != -1){  
	            bos1.write(b, 0, n);  
	        }  
	        fis.close();  
	        bos1.close();  
	        buffer = bos1.toByteArray();
            bos = new BufferedOutputStream(new FileOutputStream(filePath));
            bos.write(buffer);
            bos.flush();
        } catch (Exception e) {
			e.printStackTrace();
			return false;
		}
        finally
        {
            if (bos != null)
				try {
					bos.close();
				} catch (IOException e) {
					e.printStackTrace();
					return false;
				}
        }
		return true;
	}
}
