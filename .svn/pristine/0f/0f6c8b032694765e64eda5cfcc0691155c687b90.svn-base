package com.maryun.controller.system.fileUploads;

import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;
/**
 * 
 * @ClassName: ImageChange 
 * @Description: 生成图片或视频缩略图
 * @author SR 
 * @date 2017年2月28日
 */
public class UploadChange {
	/**
	 * 
	 * @Description:  生成图片缩略图
	 * @param is 照片输入流
	 * @param os 照片输出流
	 * @param format 缩略图格式
	 * @param width	
	 * @param height 
	 * @throws IOException
	 */
	public static void resizeImage(InputStream is, OutputStream os, String format,int width,int height) throws IOException {  
	    BufferedImage prevImage = ImageIO.read(is);  
	    int newWidth = width;  
	    int newHeight = height;  
	    BufferedImage image = new BufferedImage(newWidth, newHeight, BufferedImage.TYPE_INT_BGR);  
	    Graphics graphics = image.createGraphics();  
	    graphics.drawImage(prevImage, 0, 0, newWidth, newHeight, null);  
	    ImageIO.write(image, format, os);  
	    os.flush();  
	    is.close();  
	    os.close();  
	}
	/**
	 * 
	 * @Description: 截取视频缩略图
	 * @param is
	 * @param outPath
	 * @param format
	 * @param width
	 * @param height    
	 * @return void    
	 * @throws
	 */
	public static  void resizeVideo(String is,String outPath,int width,int height){
		List<String> cutpic = new ArrayList<String>();  
	    cutpic.add("D://ffmpeg/ffmpeg.exe");  
	    cutpic.add("-i");  
	    cutpic.add(is); // 同上（指定的文件即可以是转换为flv格式之前的文件，也可以是转换的flv文件）  
	    cutpic.add("-y");  
	    cutpic.add("-f");  
	    cutpic.add("image2");  
	    cutpic.add("-ss"); // 添加参数＂-ss＂，该参数指定截取的起始时间  
	    cutpic.add("20"); // 添加起始时间为第17秒  
	    cutpic.add("-t"); // 添加参数＂-t＂，该参数指定持续时间  
	    cutpic.add("0.001"); // 添加持续时间为1毫秒  
	    cutpic.add("-s"); // 添加参数＂-s＂，该参数指定截取的图片大小  
	    cutpic.add(String.valueOf(height)+"*"+String.valueOf(width)); // 添加截取的图片大小为350*240  
	    cutpic.add(outPath); // 添加截取的图片的保存路径  
	  
	    boolean mark = true;  
	    ProcessBuilder builder = new ProcessBuilder();  
	    try {  
	         
	        builder.command(cutpic);  
	        builder.redirectErrorStream(true);  
	        // 如果此属性为 true，则任何由通过此对象的 start() 方法启动的后续子进程生成的错误输出都将与标准输出合并，  
	        //因此两者均可使用 Process.getInputStream() 方法读取。这使得关联错误消息和相应的输出变得更容易  
	        builder.start();  
	    } catch (Exception e) {  
	        mark = false;  
	        System.out.println(e);  
	        e.printStackTrace();  
	    }  
	}
//	public static void main(String[] args) {
//		resizeVideo("d:uploads\20170228\18fed20c37ca437ca75c8b9e4b932f4d.MOV", "", 100, 100);
//	}
}
