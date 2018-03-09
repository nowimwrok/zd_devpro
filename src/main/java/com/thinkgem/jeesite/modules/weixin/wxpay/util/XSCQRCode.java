package com.thinkgem.jeesite.modules.weixin.wxpay.util;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;

import com.google.zxing.EncodeHintType;
import com.google.zxing.Writer;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

public class XSCQRCode {
	 private final String text;

	    private final HashMap<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>();

	    Writer qrWriter;

	    private int width = 235;

	    private int height = 235;

	    private ImageType imageType = ImageType.PNG;

	    private XSCQRCode(String text) {
	        this.text = text;
	        qrWriter = new QRCodeWriter();
	    }

	    public static XSCQRCode from(String text) {
	        return new XSCQRCode(text);
	    }

	    public XSCQRCode to(ImageType imageType) {
	        this.imageType = imageType;
	        return this;
	    }

	    public XSCQRCode withSize(int width, int height) {
	        this.width = width;
	        this.height = height;
	        return this;
	    }

	    public XSCQRCode withCharset(String charset) {
	        return withHint(EncodeHintType.CHARACTER_SET, charset);
	    }

	    public XSCQRCode withErrorCorrection(ErrorCorrectionLevel level) {
	        return withHint(EncodeHintType.ERROR_CORRECTION, level);
	    }

	    public XSCQRCode withHint(EncodeHintType hintType, Object value) {
	        hints.put(hintType, value);
	        return this;
	    }

	    public File file(String pathName) {
	        File file;
	        try {
	            file = createTempFile();
	          /*  MatrixToImageWriter.writeToPath(createMatrix(), imageType.toString(), file.toPath());*/
	        } catch (Exception e) {
	            throw new QRGenerationException("Failed to create QR image from text due to underlying exception", e);
	        }
	        File f = new File(pathName);
	        if(f.exists()){
	        	f.delete();
	        }
	        file.renameTo(new File(pathName));
	        return file;
	    }

	    public ByteArrayOutputStream stream() {
	        ByteArrayOutputStream stream = new ByteArrayOutputStream();
	        try {
	            writeToStream(stream);
	        } catch (Exception e) {
	            throw new QRGenerationException("Failed to create QR image from text due to underlying exception", e);
	        }

	        return stream;
	    }

	    public void writeTo(OutputStream stream) {
	        try {
	            writeToStream(stream);
	        } catch (Exception e) {
	            throw new QRGenerationException("Failed to create QR image from text due to underlying exception", e);
	        }
	    }

	    private void writeToStream(OutputStream stream) throws IOException, WriterException {
	        MatrixToImageWriter.writeToStream(createMatrix(), imageType.toString(), stream);
	    }

	    private BitMatrix createMatrix() throws WriterException {
	        return qrWriter.encode(text, com.google.zxing.BarcodeFormat.QR_CODE, width, height, hints);
	    }

	    private File createTempFile() throws IOException {
	        File file = File.createTempFile("QRCode", "." + imageType.toString().toLowerCase());
	        file.deleteOnExit();
	        return file;
	    }

	    private File createTempFile(String name) throws IOException {
	        File file = File.createTempFile(name, "." + imageType.toString().toLowerCase());
	        file.deleteOnExit();
	        return file;
	    }
	    
	    public enum ImageType {
	        JPG, GIF, PNG
	    }
	    
	    public class QRGenerationException extends RuntimeException {
	        public QRGenerationException(String message, Throwable underlyingException) {
	            super(message, underlyingException);
	        }
	    }
}
