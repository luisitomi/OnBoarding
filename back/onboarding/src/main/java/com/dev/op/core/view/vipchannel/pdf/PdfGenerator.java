package com.dev.op.core.view.vipchannel.pdf;


import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
import com.itextpdf.text.pdf.PdfWriter;

import com.dev.op.core.dto.vipchannel.getListPayOneModel;
import com.dev.op.core.dto.vipchannel.getListPayThreeModel;
import com.dev.op.core.dto.vipchannel.getListPayTwoModel;
import com.dev.op.core.dto.vipchannel.getManagerSumationModel;

public class PdfGenerator {
	
	public static ByteArrayInputStream pdfPayOne (List<getListPayOneModel> planilla)throws MalformedURLException, IOException  {
		
		Document documento = new Document(PageSize.A4);
		
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		
		try {
			
			String imageUrl = "file:///C:/Users/Luis/Desktop/OnBoarding/back/onboarding/src/main/resources/img/planilla.jpg";
						
			Image img = Image.getInstance(new URL(imageUrl));
			img.disableBorderSide(Rectangle.BOX);
			
			float documentWidth = documento.getPageSize().getWidth() - documento.leftMargin() - documento.rightMargin();
			float documentHeight = documento.getPageSize().getHeight() - documento.topMargin()/2 - documento.bottomMargin()/2;
			img.scaleToFit(documentWidth + 10, documentHeight);
			img.setAbsolutePosition(50, 10);
			
			PdfReader reader = new PdfReader("https://www.uv.mx/personal/artulopez/files/2012/08/02_TS-y-TI.pdf");
			 
			PdfStamper stamp = new PdfStamper(reader,new FileOutputStream("text1.pdf")); 
			int i = 1; 
		    PdfContentByte under; 
		    PdfContentByte over; 
		    
		    Font fant = FontFactory.getFont(FontFactory.HELVETICA, 5);
			fant.setColor(BaseColor.BLACK);
			
		    PdfPTable table = new PdfPTable(7);
			table.setWidthPercentage(100);
			table.setWidths(new float[] {1f, 1f,4f,1f, 1f,1f, 1f});
			
			PdfPCell hcell;
			
			hcell = new PdfPCell();
			
		    BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA,BaseFont.WINANSI, BaseFont.EMBEDDED); 
		    
		    for(getListPayOneModel planillas : planilla) {
				
				hcell = new PdfPCell(new Phrase(planillas.getId(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(planillas.getCode(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(planillas.getClient(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(planillas.getAmountOne().toString(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(planillas.getAmountTwo().toString(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(planillas.getAmountThree(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(planillas.getSumation().toString(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
		    }
		    
			PdfWriter.getInstance(documento, baos);
			
			documento.open();
			
			 while (i < 5)
			 {
			    under = stamp.getUnderContent(i);
			    under.addImage(img);
			    
			    over = stamp.getOverContent(i); 
			    over.beginText(); 
			    over.addImage(img);
			    over.setFontAndSize(bf, 5); 
			    over.showText("page " + i); 
			    over.endText();
			    
			    documento.add(img);
			    if(i + 1 == 5) {
				    documento.add(img);
				    documento.add(table);
				    documento.add(img);
			    }
			    i++;
			 }
			 documento.add(img);
		 	 stamp.close();
		 	 documento.close();
			
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		
		return new ByteArrayInputStream(baos.toByteArray());
		
	}
	public static ByteArrayInputStream pdfPayTwo (List<getListPayTwoModel> planilla)throws MalformedURLException, IOException  {
		
		Document documento = new Document(PageSize.A4);
		
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		
		try {
			
			String imageUrl = "file:///C:/Users/Luis/Desktop/OnBoarding/back/onboarding/src/main/resources/img/planilla.jpg";
						
			Image img = Image.getInstance(new URL(imageUrl));
			img.disableBorderSide(Rectangle.BOX);
			
			float documentWidth = documento.getPageSize().getWidth() - documento.leftMargin() - documento.rightMargin();
			float documentHeight = documento.getPageSize().getHeight() - documento.topMargin()/2 - documento.bottomMargin()/2;
			img.scaleToFit(documentWidth + 10, documentHeight);
			img.setAbsolutePosition(50, 10);
			
			PdfReader reader = new PdfReader("https://www.uv.mx/personal/artulopez/files/2012/08/02_TS-y-TI.pdf");
			 
			PdfStamper stamp = new PdfStamper(reader,new FileOutputStream("text1.pdf")); 
			int i = 1; 
		    PdfContentByte under; 
		    PdfContentByte over; 
		    
		    Font fant = FontFactory.getFont(FontFactory.HELVETICA, 5);
			fant.setColor(BaseColor.BLACK);
			
		    PdfPTable table = new PdfPTable(7);
			table.setWidthPercentage(100);
			table.setWidths(new float[] {1f, 1f,4f,1f, 1f,1f, 1f});
			
			PdfPCell hcell;
			
			hcell = new PdfPCell();
			
		    BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA,BaseFont.WINANSI, BaseFont.EMBEDDED); 
		    
		    for(getListPayTwoModel planillas : planilla) {
				
				hcell = new PdfPCell(new Phrase(planillas.getId(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(planillas.getCode(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(planillas.getClient(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(planillas.getAmountOne(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(planillas.getAmountTwo(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(planillas.getAmountThree(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(planillas.getSumation(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
		    }
		    
			PdfWriter.getInstance(documento, baos);
			
			documento.open();
			
			 while (i < 5)
			 {
			    under = stamp.getUnderContent(i);
			    under.addImage(img);
			    
			    over = stamp.getOverContent(i); 
			    over.beginText(); 
			    over.addImage(img);
			    over.setFontAndSize(bf, 5); 
			    over.showText("page " + i); 
			    over.endText();
			    
			    documento.add(img);
			    if(i + 1 == 5) {
				    documento.add(img);
				    documento.add(table);
				    documento.add(img);
			    }
			    i++;
			 }
			 documento.add(img);
		 	 stamp.close();
		 	 documento.close();
			
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		
		return new ByteArrayInputStream(baos.toByteArray());
	}
	public static ByteArrayInputStream pdfPayThree (List<getListPayThreeModel> planilla)throws MalformedURLException, IOException  {
		
		Document documento = new Document(PageSize.A4);
		
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		
		try {
			
			String imageUrl = "file:///C:/Users/Luis/Desktop/OnBoarding/back/onboarding/src/main/resources/img/planilla.jpg";
						
			Image img = Image.getInstance(new URL(imageUrl));
			img.disableBorderSide(Rectangle.BOX);
			
			float documentWidth = documento.getPageSize().getWidth() - documento.leftMargin() - documento.rightMargin();
			float documentHeight = documento.getPageSize().getHeight() - documento.topMargin()/2 - documento.bottomMargin()/2;
			img.scaleToFit(documentWidth + 10, documentHeight);
			img.setAbsolutePosition(50, 10);
			
			PdfReader reader = new PdfReader("https://www.uv.mx/personal/artulopez/files/2012/08/02_TS-y-TI.pdf");
			 
			PdfStamper stamp = new PdfStamper(reader,new FileOutputStream("text1.pdf")); 
			int i = 1; 
		    PdfContentByte under; 
		    PdfContentByte over; 
		    
		    Font fant = FontFactory.getFont(FontFactory.HELVETICA, 5);
			fant.setColor(BaseColor.BLACK);
			
		    PdfPTable table = new PdfPTable(7);
			table.setWidthPercentage(100);
			table.setWidths(new float[] {1f, 1f,4f,1f, 1f,1f, 1f});
			
			PdfPCell hcell;
			
			hcell = new PdfPCell();
			
		    BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA,BaseFont.WINANSI, BaseFont.EMBEDDED); 
		    
		    for(getListPayThreeModel planillas : planilla) {
				
				hcell = new PdfPCell(new Phrase(planillas.getId(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(planillas.getCode(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(planillas.getClient(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(planillas.getAmountOne(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(planillas.getAmountTwo(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(planillas.getAmountThree(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(planillas.getSumation(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
		    }
		    
			PdfWriter.getInstance(documento, baos);
			
			documento.open();
			
			 while (i < 5)
			 {
			    under = stamp.getUnderContent(i);
			    under.addImage(img);
			    
			    over = stamp.getOverContent(i); 
			    over.beginText(); 
			    over.addImage(img);
			    over.setFontAndSize(bf, 5); 
			    over.showText("page " + i); 
			    over.endText();
			    
			    documento.add(img);
			    if(i + 1 == 5) {
				    documento.add(img);
				    documento.add(table);
				    documento.add(img);
			    }
			    i++;
			 }
			 documento.add(img);
		 	 stamp.close();
		 	 documento.close();
			
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		
		return new ByteArrayInputStream(baos.toByteArray());
	}
	public static ByteArrayInputStream pdfPaySumation (List<getManagerSumationModel> sumation)throws MalformedURLException, IOException  {
		
		Document documento = new Document(PageSize.A4);
		
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		
		try {
			
			String imageUrl = "file:///C:/Users/Luis/Desktop/OnBoarding/back/onboarding/src/main/resources/img/sumatoria.jpg";
						
			Image img = Image.getInstance(new URL(imageUrl));
			img.disableBorderSide(Rectangle.BOX);
			
			float documentWidth = documento.getPageSize().getWidth() - documento.leftMargin() - documento.rightMargin();
			float documentHeight = documento.getPageSize().getHeight() - documento.topMargin()/2 - documento.bottomMargin()/2;
			img.scaleToFit(documentWidth + 10, documentHeight);
			img.setAbsolutePosition(50, 10);
			
			PdfReader reader = new PdfReader("https://www.uv.mx/personal/artulopez/files/2012/08/02_TS-y-TI.pdf");
			 
			PdfStamper stamp = new PdfStamper(reader,new FileOutputStream("text1.pdf")); 
			int i = 1; 
		    PdfContentByte under; 
		    PdfContentByte over; 
		    
		    Font fant = FontFactory.getFont(FontFactory.HELVETICA, 8);
			fant.setColor(BaseColor.BLACK);
			
		    PdfPTable table = new PdfPTable(7);
			table.setWidthPercentage(100);
			table.setWidths(new float[] {1f, 1f,3f,1f, 1f,1f, 1f});
			
			PdfPCell hcell;
			
			hcell = new PdfPCell();
			
		    BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA,BaseFont.WINANSI, BaseFont.EMBEDDED); 
		    
		    for(getManagerSumationModel sumations : sumation) {
				
				hcell = new PdfPCell(new Phrase(" "));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(" "));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(sumations.getManager(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(sumations.getAmount(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(" "));
				hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(" "));
				hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(" "));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
		    }
		    
			PdfWriter.getInstance(documento, baos);
			
			documento.open();
			
			 while (i < 5)
			 {
			    under = stamp.getUnderContent(i);
			    under.addImage(img);
			    
			    over = stamp.getOverContent(i); 
			    over.beginText(); 
			    over.addImage(img);
			    over.setFontAndSize(bf, 5); 
			    over.showText("page " + i); 
			    over.endText();
			    
			    documento.add(img);
			    if(i + 1 == 5) {
				    documento.add(img);
				    documento.add(table);
				    documento.add(img);
			    }
			    i++;
			 }
			 documento.add(img);
		 	 stamp.close();
		 	 documento.close();
			
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		
		return new ByteArrayInputStream(baos.toByteArray());
	}
}