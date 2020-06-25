package com.dev.op.core.view.vipchannel.pdf;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
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
import com.dev.op.core.dto.vipchannel.getListServiceBySaleModel;
import com.dev.op.core.dto.vipchannel.getManagerSumationModel;
import com.dev.op.core.dto.vipchannel.returnGetContractModel;

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
			
			PdfReader reader = new PdfReader("file:///C:/Users/Luis/Desktop/OnBoarding/back/onboarding/src/main/resources/pdf/pdf.pdf");
			 
			PdfStamper stamp = new PdfStamper(reader,new FileOutputStream("archivo.pdf")); 
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
			
			PdfReader reader = new PdfReader("file:///C:/Users/Luis/Desktop/OnBoarding/back/onboarding/src/main/resources/pdf/pdf.pdf");
			 
			PdfStamper stamp = new PdfStamper(reader,new FileOutputStream("archivo.pdf")); 
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
			
			PdfReader reader = new PdfReader("file:///C:/Users/Luis/Desktop/OnBoarding/back/onboarding/src/main/resources/pdf/pdf.pdf");
			 
			PdfStamper stamp = new PdfStamper(reader,new FileOutputStream("archivo.pdf")); 
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
			
			PdfReader reader = new PdfReader("file:///C:/Users/Luis/Desktop/OnBoarding/back/onboarding/src/main/resources/pdf/pdf.pdf");
			 
			PdfStamper stamp = new PdfStamper(reader,new FileOutputStream("archivo.pdf")); 
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
	public static ByteArrayInputStream pdfBySeller (List<getListServiceBySaleModel> reporte)throws MalformedURLException, IOException  {
		
		Document documento = new Document(PageSize.A4);
		
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		
		try {
			
			String imageUrl = "file:///C:/Users/Luis/Desktop/OnBoarding/back/onboarding/src/main/resources/img/contrato.jpg";
						
			Image img = Image.getInstance(new URL(imageUrl));
			img.disableBorderSide(Rectangle.BOX);
			
			float documentWidth = documento.getPageSize().getWidth() - documento.leftMargin() - documento.rightMargin();
			float documentHeight = documento.getPageSize().getHeight() - documento.topMargin()/2 - documento.bottomMargin()/2;
			img.scaleToFit(documentWidth + 10, documentHeight);
			img.setAbsolutePosition(20, 10);
			
			PdfReader reader = new PdfReader("file:///C:/Users/Luis/Desktop/OnBoarding/back/onboarding/src/main/resources/pdf/pdf.pdf");
			 
			PdfStamper stamp = new PdfStamper(reader,new FileOutputStream("archivo.pdf")); 
			int i = 1; 
		    PdfContentByte under; 
		    PdfContentByte over; 
		    
		    Font fant = FontFactory.getFont(FontFactory.HELVETICA, 5);
			fant.setColor(BaseColor.BLACK);
			
		    PdfPTable table = new PdfPTable(8);
			table.setWidthPercentage(100);
			table.setWidths(new float[] { 0.5f,2.5f,1f, 2.5f,1f, 1f,2.5f,1f });
			
			PdfPCell hcell;
			
			hcell = new PdfPCell();
			
		    BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA,BaseFont.WINANSI, BaseFont.EMBEDDED); 
		    
		    for(getListServiceBySaleModel reportes : reporte) {
		    	
				hcell = new PdfPCell(new Phrase(reportes.getCode(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(reportes.getClient(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(reportes.getAgreed(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(reportes.getDescription(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(reportes.getService(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_LEFT);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(reportes.getInstall(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(reportes.getSeller(),fant));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(reportes.getStatus(),fant));
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
	public static ByteArrayInputStream pdfContrat(returnGetContractModel contrato) {
		Document documento = new Document(PageSize.A4);
		
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		
		try{
			
			String imageUrl = "file:///C:/Users/Luis/Desktop/OnBoarding/back/onboarding/src/main/resources/img/logo.png";
			
			Image img = Image.getInstance(new URL(imageUrl));
			img.scaleAbsolute(80f, 55f);
			img.disableBorderSide(Rectangle.BOX);
			img.setBackgroundColor(BaseColor.WHITE);
			
			PdfPTable tableLogo = new PdfPTable(2);
			tableLogo.setWidths(new float[] {1.2f,8.8f});
			tableLogo.setWidthPercentage(100);
			
			PdfPTable table = new PdfPTable(1);
			table.setWidthPercentage(100);

			PdfPCell hcell;
			hcell = new PdfPCell();
			PdfPCell hcellD;
			hcellD = new PdfPCell();
			PdfPCell hcellLogo;
			hcellLogo = new PdfPCell();
			
			Paragraph celdas = new Paragraph();
			Paragraph celda = new Paragraph();
			Paragraph celdaD = new Paragraph();
			
			Font fantUnderLogo = new Font(Font.FontFamily.HELVETICA,10,Font.BOLD|Font.ITALIC,BaseColor.BLACK);
			Font fant = new Font(Font.FontFamily.HELVETICA,9,Font.NORMAL|Font.ITALIC,BaseColor.BLUE);
			
			celdas.add(new Phrase(new Chunk(img, 0, 0)));
			celdas.setAlignment(Element.ALIGN_TOP);
			hcellLogo.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcellLogo.setVerticalAlignment(Element.ALIGN_MIDDLE);
			hcellLogo.addElement(celdas);
			hcellLogo.disableBorderSide(Rectangle.BOX);
			tableLogo.addCell(hcellLogo);
			
			if(contrato.getDocument().length() == 8) {
				hcellLogo = new PdfPCell(new Phrase("CONTRATO DE PRESTACIÓN DE SERVICIOS PÚBLICOS DE TELECOMUNICACIONES\n"
						+ "DISTRIBUCIÓN DE RADIOFUSIÓN POR CABLE Y/O ACCESO DE INTERNET",fantUnderLogo));
				hcellLogo.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcellLogo.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcellLogo.disableBorderSide(Rectangle.BOX);
				tableLogo.addCell(hcellLogo);
				
				celda.add(new Phrase("                   " + contrato.getName(),fant));
				celda.setAlignment(Element.ALIGN_BOTTOM);
				hcell.addElement(celda);
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				celdaD.add(new Phrase("            " + contrato.getDocument() + "                                                              " + contrato.getDirection(),fant));
				celdaD.setAlignment(Element.ALIGN_BOTTOM);
				hcellD.addElement(celdaD);
				hcellD.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcellD.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcellD.disableBorderSide(Rectangle.BOX);
				table.addCell(hcellD);	
			}else {
				hcellLogo = new PdfPCell(new Phrase("CONTRATO DE PRESTACIÓN DE SERVICIOS PÚBLICOS DE TELECOMUNICACIONES\n"
						+ "DISTRIBUCIÓN DE RADIOFUSIÓN POR CABLE Y/O ACCESO DE INTERNET",fantUnderLogo));
				hcellLogo.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcellLogo.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcellLogo.disableBorderSide(Rectangle.BOX);
				tableLogo.addCell(hcellLogo);
				
				celda.add(new Phrase("                   " + contrato.getName(),fant));
				celda.setAlignment(Element.ALIGN_BOTTOM);
				hcell.addElement(celda);
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				celdaD.add(new Phrase("            " + contrato.getDocument() + "                                                              " + contrato.getDirection(),fant));
				celdaD.setAlignment(Element.ALIGN_BOTTOM);
				hcellD.addElement(celdaD);
				hcellD.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcellD.setVerticalAlignment(Element.ALIGN_MIDDLE);
				hcellD.disableBorderSide(Rectangle.BOX);
				table.addCell(hcellD);
			}
			
			BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA,BaseFont.WINANSI, BaseFont.EMBEDDED); 
			
			PdfReader reader = new PdfReader("file:///C:/Users/Luis/Desktop/OnBoarding/back/onboarding/src/main/resources/pdf/pdf.pdf");
			PdfStamper stamp = new PdfStamper(reader,new FileOutputStream("archivo1.pdf")); 
			
			int i = 1; 
		    PdfContentByte under; 
		    PdfContentByte over; 
		    
		    PdfReader readers = new PdfReader("file:///C:/Users/Luis/Desktop/OnBoarding/back/onboarding/src/main/resources/pdf/pdf.pdf");
			PdfStamper stamps = new PdfStamper(readers,new FileOutputStream("archivos2.pdf")); 
			
		    PdfContentByte unders; 
		    PdfContentByte overs; 
		    
		    PdfReader readersT = new PdfReader("file:///C:/Users/Luis/Desktop/OnBoarding/back/onboarding/src/main/resources/pdf/pdf.pdf");
			PdfStamper stampsT = new PdfStamper(readersT,new FileOutputStream("archivo3.pdf")); 
			
		    PdfContentByte undersT; 
		    PdfContentByte oversT; 
		    
		    String c1 = "file:///C:/Users/Luis/Desktop/OnBoarding/back/onboarding/src/main/resources/img/C1.jpg";
			
		    Image c1I = Image.getInstance(new URL(c1));
			c1I.disableBorderSide(Rectangle.BOX);
			float documentWidth = documento.getPageSize().getWidth() - documento.leftMargin() - documento.rightMargin();
			float documentHeight = documento.getPageSize().getHeight() - documento.topMargin() - documento.bottomMargin();
			c1I.scaleToFit(documentWidth, documentHeight);
			c1I.setAbsolutePosition(45, 10);
			
			String c2 = "file:///C:/Users/Luis/Desktop/OnBoarding/back/onboarding/src/main/resources/img/C2.jpg";
			
		    Image c1II = Image.getInstance(new URL(c2));
		    c1II.disableBorderSide(Rectangle.BOX);
			c1II.scaleToFit(documentWidth, documentHeight);
			c1II.setAbsolutePosition(45, 0);
			
			String c3 = "file:///C:/Users/Luis/Desktop/OnBoarding/back/onboarding/src/main/resources/img/C3.jpg";
			
		    Image c1III = Image.getInstance(new URL(c3));
		    c1III.disableBorderSide(Rectangle.BOX);
		    c1III.scaleToFit(documentWidth, documentHeight);
		    c1III.setAbsolutePosition(45, 0);
			
			PdfWriter.getInstance(documento, baos);
			
			documento.open();
			while (i < 10)
			 {
			    under = stamp.getUnderContent(i);
			    under.addImage(c1I);
			    
			    over = stamp.getOverContent(i); 
			    over.beginText(); 
			    over.addImage(c1I);
			    over.setFontAndSize(bf, 5); 
			    over.showText("page " + i); 
			    over.endText();
			    i++;
			 }

			documento.add(c1I);
			stamp.close();
			
		    if(contrato.getDocument().length() == 8) {
		    	documento.add(tableLogo);
		    	documento.add(new Phrase("\n\n"));
			    documento.add(table);
			    documento.newPage();
		    }else {
		    	
		    }
			
			i = 1;
			while (i < 10)
			 {
			    unders = stamps.getUnderContent(i);
			    unders.addImage(c1II);
			    
			    overs = stamps.getOverContent(i); 
			    overs.beginText(); 
			    overs.addImage(c1II);
			    overs.setFontAndSize(bf, 5); 
			    overs.showText("page " + i); 
			    overs.endText();
			    i++;
			 }
			documento.add(c1II);
			documento.newPage();
			stamps.close();
			
			i = 1;
			while (i < 10)
			 {
			    undersT = stampsT.getUnderContent(i);
			    undersT.addImage(c1III);
			    
			    oversT = stampsT.getOverContent(i); 
			    oversT.beginText(); 
			    oversT.addImage(c1III);
			    oversT.setFontAndSize(bf, 5); 
			    oversT.showText("page " + i); 
			    oversT.endText();
			    i++;
			 }
			documento.add(c1III);
		    
			stampsT.close();
			documento.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return new ByteArrayInputStream(baos.toByteArray());
	}
}