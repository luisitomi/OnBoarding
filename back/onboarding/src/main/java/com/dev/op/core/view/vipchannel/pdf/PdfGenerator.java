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
			
			PdfReader reader = new PdfReader("https://www.uv.mx/personal/artulopez/files/2012/08/02_TS-y-TI.pdf");
			 
			PdfStamper stamp = new PdfStamper(reader,new FileOutputStream("text1.pdf")); 
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
			
			String imageUrl = "https://scontent.flim19-1.fna.fbcdn.net/v/t1.0-9/54403626_313172756011207_6011524514276442112_o.png?_nc_cat=102&_nc_sid=09cbfe&_nc_eui2=AeFE-kMZzn5KtzRIL9flVUtm5oyw_8R4xKjmjLD_xHjEqHqq4qvqtZU01ALg__KSkMScP-AOhicwfKn-XR2wcw_1&_nc_ohc=U9DAsuqNud8AX-QgXYW&_nc_ht=scontent.flim19-1.fna&oh=4b56a5c2edd79ac9618af8a7d01cd641&oe=5F1073B7";
			
			Image img = Image.getInstance(new URL(imageUrl));
			img.scaleAbsolute(80f, 65f);
			img.disableBorderSide(Rectangle.BOX);
			
			PdfPTable table = new PdfPTable(1);
			PdfPTable tableLogo = new PdfPTable(2);
			table.setWidthPercentage(100);
			tableLogo.setWidths(new float[] {1.2f,8.8f});
			tableLogo.setWidthPercentage(100);
			
			PdfPCell hcell;
			hcell = new PdfPCell();

			PdfPCell hcellLogo;
			hcellLogo = new PdfPCell();
			
			Paragraph celdas = new Paragraph();
			
			Font fant = new Font(Font.FontFamily.HELVETICA,10,Font.NORMAL,BaseColor.BLACK);
			Font fantUnder = new Font(Font.FontFamily.HELVETICA,10,Font.BOLD|Font.UNDERLINE,BaseColor.BLACK);
			Font fantUnderLogo = new Font(Font.FontFamily.HELVETICA,10,Font.BOLD|Font.ITALIC,BaseColor.BLACK);
			Font fantUnderCursive = new Font(Font.FontFamily.HELVETICA,10,Font.BOLD|Font.UNDERLINE|Font.ITALIC,BaseColor.BLACK);
			Font fantUnderNotCursive = new Font(Font.FontFamily.HELVETICA,10,Font.BOLD|Font.UNDERLINE,BaseColor.BLACK);
			
			celdas.add(new Phrase(new Chunk(img, 0, 0)));
			celdas.setAlignment(Element.ALIGN_TOP);
			hcellLogo.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcellLogo.setVerticalAlignment(Element.ALIGN_MIDDLE);
			hcellLogo.addElement(celdas);
			hcellLogo.disableBorderSide(Rectangle.BOX);
			tableLogo.addCell(hcellLogo);
			
			hcellLogo = new PdfPCell(new Phrase("CONTRATO DE PRESTACIÓN DE SERVICIOS PÚBLICOS DE TELECOMUNICACIONES\n"
					+ "DISTRIBUCIÓN DE RADIOFUSIÓN POR CABLE Y/O ACCESO DE INTERNET",fantUnderLogo));
			hcellLogo.setHorizontalAlignment(Element.ALIGN_CENTER);
			hcellLogo.setVerticalAlignment(Element.ALIGN_MIDDLE);
			hcellLogo.disableBorderSide(Rectangle.BOX);
			tableLogo.addCell(hcellLogo);
			
			Integer i = contrato.getDocument().length();
			
			if(i == 8) {
				
				hcell = new PdfPCell(new Phrase("Conste por el presente documento el contrato de Prestación de Servicios Públicos de"
						+ "Telecomunicaciones Distribución de Radiodifusion por cable (Televisión por cable) y/o Acceso a Internet - "
						+ "que celebran de una parte, VIP CHANNEL S.A.C. identificada con RUC N° 205150906400, con domicilio legal para "
						+ "los efectos del presente contrato en Av. Túpac Amaru N°306 2do piso-Huacho, en adelante CABLE COLOR; y de la "
						+ "otra parte:", fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(""
				   		+ "Sr./Sra " + contrato.getName() + " identificado/a con D.N.I.:" + contrato.getDocument() + ", con domicilio en "
				   		+ contrato.getDirection() + " Empresa ............................. identificada con RUC N° ............................. "
				   		+ "con domicilio ............................. representada por el señor(a) ............................. según poder "
				   		+ "en inscrito en ............................. en adelante EL ABONADO, en los términos y condiciones siguientes:",fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase("PRIMERA.-",fantUnder));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(""
						+ "              CABLE COLOR es una empresa cuyo objeto social la faculta a prestar Servicios Públicos de "
						+ "Telecomunicaciones tales como Televisión por Cable,Televisión VHF,UHF,Internet y otros. \n"
						+ "Asimismo CABLE COLOR ha suscrito un Contrato de Concesión Única con el Ministerio de "
						+ "Transporte, Comunicaciones, Vivienda y Construcción para la Prestación de Servicios Públicos de Telecomunicaciones. \n"
						+ "Concesión única esta autorizada por Resolucón Ministerial N° 1053-2019-MTC/1.03.",fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase("SEGUNDA.-",fantUnder));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(""
						+ "                     Por el presente contrato CABLE COLOR se obliga a prestar a EL ABONADO lo siguiente: \n"
						+ "                     a) Servicio Público de Distribución de Radiofusión por Cable o Interneten el domicilio señalado en el\n"
						+ "                     Anexo N°1 que forma parte integrante del presente contrato. \n"
						+ "En adelante indistinta o conjuntamente se les denominará el Servicio",fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase("TERCERA.-",fantUnder));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(""
						+ "                     Restribución de EL ABONADO:",fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase("3.1.Respecto al Servicio Público de Distribución de Radiofusión por Cable",fantUnderCursive));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(""
						+ "La retribución que se obliga a pagar EL ABONADO se compone de un cargo único de conexión a la red y una tarifa peródica, cuyos montos se "
						+ "detallan en el ANEXO N°01. La facturación de la tarifa será efectuada por CABLE COLOR en el momento de la retribución "
						+ "o pago del servicio, desde la fecha de conexión del servicio a la red.\n"
						+ "El pago del cargo único por conexión, así como lo de la tarifa mensual deberá efectuarse por EL ABONADO en el lugar y en "
						+ "la oportunidad establecida en el ANEXO N°01 del contrato, bajo sanciónde quedar constituido en mora en forma automática.\n"
						+ "En caso de mora EL ABONADO se obliga a pagar, adicionalmente, los intereses legales máximos que fija el Banco Central de "
						+ "Reserva del Perú.\n"
						+ "Las tarifas que se consignan en el ANEXON°01 podrán ser modificadas por CABLE COLOR.\n"
						+ "CABLE COLOR podrá, si lo considera conveniente, exigir a EL ABONADO la constitución de una garantía que respalde  el pago "
						+ "del servicio contratado.",fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase("3.2.Respecto al Servicio Público de Acceso a Internet",fantUnderCursive));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(""
						+ "La retribución que se obliga a pagar EL ABONADO se compone de un cargo único de conexión al sistema pertinente "
						+ "y una tarifa periódica, cuyos montos se detallan en el ANEXO N°01 La facturación de la tarifa será efectuada por CABLE COLOR en el momento de la retribución \n"
						+ "o pago del servicio, desde la fecha de conexión del servicio a la red.\n"
						+ "El pago del cargo único por conexión, así como lo de la tarifa mensual deberá efectuarse por EL ABONADO en el lugar y en "
						+ "la oportunidad establecida en el ANEXO N°01 del contrato, bajo sanciónde quedar constituido en mora en forma automática.\n"
						+ "En caso de mora EL ABONADO se obliga a pagar, adicionalmente, los intereses legales máximos que fija el Banco Central de "
						+ "Reserva del Perú.\n"
						+ "Las tarifas que se consignan en el ANEXON°01 podrán ser modificadas por CABLE COLOR.\n"
						+ "CABLE COLOR podrá, si lo considera conveniente, exigir a EL ABONADO la constitución de una garantía que respalde  el pago "
						+ "del servicio contratado.",fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase("\nCUARTA.-",fantUnder));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(""
						+ "                     Instalación de Servicio:",fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase("4.1.Respecto al Servicio Público de Distribución de Radiofusión por Cable",fantUnderNotCursive));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(
						  "    a) CABLE COLOR instalará el servicio siempre y cuando existan las facilidades técnicas del caso.\n"
						+ "        La instalación del servicio supone la conexión de un(1) receptor a la red de distribución. EL ABONADO "
						+ "podrá solicitar la conexión de receptores adicionales, para lo cual deberá pagar los cargos"
						+ "correspondientes.\n"
						+ "    b) Por razones de mantenimiento CABLE COLOR podrá suspender temporalmente el servicio, en forma total o parcial.\n"
						+ "    c) Los equipos, materiales y accesorios instalados para la prestación del servicio son propiedad de CABLE COLOR.\n"
						+ "       EL ABONADO no podrá manipular, ceder, compartir, conectar sustituir ni efectuar modificaciones en los elementos "
						+ "instalados por CABLE COLOR, siendo responsables por los daños que pudieran sufir los mismos, así como pérdida, "
						+ "destrucción o deterioro, excepto cuando medie caso fortuito o fuerza mayor, sin perjuicio de las demás "
						+ "responsabilidades que pudieran derivarse por la manipulación indebida de tales elementos.",fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(
						  "    d) Las averíasdeficientes e interrupciones del servicio originadas en los equipos e instalaciones de CABLE COLOR "
						+ "serán subsanadas por ésta en el más breve plazo desde que tenga conocimiento de ellas. La reparación de averías se efectuará "
						+ "sin cargo alguno por EL ABONADO, salvo cuando las causas de su pcurrencia le sean imputable.\n"
						+ "    e) CABLE COLOR queda facultada asimismmp de suspender el servicio cuando la boleta y/o factura correspondiente al pago "
						+ "de la tarifa mensual, no es cancelado por EL ABONADO en la fecha de vencimiento, o EL ABONADO presenta un reclamo por facturación "
						+ "y no ha realizado el pago del monto que no se encuentra comprendido en el reclamo, en la fecha de vencimiento; esta suspensión "
						+ "se realizará a partir del día siguiente a este vencimiento. La suspensión se matendrá hasta que cesen las causas mencionadas, "
						+ "sin perjuicio de la facultad de CABLE COLOR de resolver el contrato, de conformidad con las normas legalesvigentes. En estos casos "
						+ "EL ABONADO aumirá el cargo de corte y reconexión delservicio, cuyo valor se encuentra consignado en el ANEXO del presente contrato.\n"
						+ "        No obstante lo anterior, EL ABONADO queda obligado a pagar la retribución mensual que corresponda hasta el día efectivo "
						+ "de suspensión del servicio.\n"
						+ "    f) Si transcurriesen veinte (20) días caendario después de la suspensión del servicio por falta de pago y EL ABONADO no cumpliera "
						+ "con su obligación de pago y siempre que no exista reclamo pendiente sobre el monto adeudado, CABLE COLOR podrá cortar el servicio de "
						+ "EL ABONADO, previa remisión de un aviso mediante documento que deje ocnstancia de la comunicación, con una anticipación no menor de "
						+ "de siete (7) días calendario a la fecha de corte.\n"
						+ "    g) Dicho aviso previo deberá indicar claramente el monto adeudado, la tasa de interés aplicable, el o los recibos no cabcelados que originaron "
						+ "la deuda, la fecha en que se efectuará el corte, la tarifa que se aplicará por la reactivación del servicio si de hace efectivo "
						+ "el corte y el plazo que tendrá EL ABONADO para cancelar su deuda antes de que se proceda a la baja definitivamente del servicio.\n"
						+ "    h) CABLE COLOR deberá reconectar el servicio cortado cuando se haya efectuado el pago de la totatlidad de la suma adeudada y el "
						+ "respectivol interés así como la tarifa por concepto de reconexión por corte.\n"
						+ "    i) EL ABONADO deberá efectuar el pago correspondiente dentro de los treinta (30) días calendario siguientes a la fecha en que se haya efectuado "
						+ "el corte. Transcurrido dicho plazo, CABLE COLOR podrá dar de baja el servicio.",fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase("4.2.Respecto al Servicio Público de Acceso a Internet",fantUnderNotCursive));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(
						  "    a) CABLE COLOR realizará la configuración del Servicio. Usted deberá mantener en reserva y custodia sus cuentas "
						+ "y claves de acceso.\n"
						+ "    b) La velocidad de transmisión del Servicio depende, entre ellos, de: (i) el volumen de trafico y congestión de la red "
						+ "en internet; (ii) características técnicas y capacidades de su computadora; (iii) el uso excesivo de aplicacines ''peer to peer'' "
						+ "(punto a punto o P2P) u otras similares.\n"
						+ "    c) CABLE COLOR entregará en calidad de comodato, los equipos indicados en el ANEXO N°01, los cales son necesarios para "
						+ "la conexión y prestación del sericio.\n"
						+ "    d) EL ABONADO deberá utilizar el servicio cumpliendo con la normativa legal, moral, las buenas costumbres y el orden "
						+ "público relacionados con el uso de internet. Asimismo, deberá respetar las normas que regulan el envío y recepción "
						+ "de mensajes de correo electrónico con contenido publicitario no solicitado.\n"
						+ "    e) EL ABONADO no debe realizar las siguientes actividades: la pornografía infantil, el ''spam'', infrigir el secreto "
						+ "de las telecomunicaciones y la protección de datos personales; infringir los derechos de propiedad intelectual, realizar "
						+ "actividades de ''hacking'' y similares.\n"
						+ "    f) EL ABONADO no deberá realizar transmisiones o difusiones de materiales con contenidos que violen la legislación "
						+ "o propagar virus informáticos u otros programas dañinos.\n"
						+ "    g) CABLE COLOR asume responsabilidad por la prestación del Servicio en las condiciones pactadas. No asumirá "
						+ "responsabilidad por causas que no le sean directamente imputables, tales como: (i) los usos y contenidos de la "
						+ "información a la que usted acceda a través del Servicio; (ii) la información que le sea transmitida por terceros; (iii) "
						+ "la información albergada o transmitida en cualquiera de sus formas a través del Servicio qe le eprtenezca, siendo "
						+ "usted responsable por el contenido de la misma; y, (iv) averías y desperfectos en el Servicio derivados de los equipos que "
						+ "usted haya adquirido a terceros, de la manipulación indebida de los bienes que CABLE COLOR le pudiera haber proporcionado o de la "
						+ "configuración de la instalación que usted realice, en cuyo caso deberá asumir los costos de reparación.\n"
						+ "    h) EL ABONADO es responsable de las consecuencias del incumplimiento de los literales e), f) y g) del presente "
						+ "numeral.\n"
						+ "    i) La unidad de medición de la provisión de Servicio de acceso a internet es de kilobyte(KB).\n"
						+ "    j) La cobertura del Servicio se detalla en el ANEXO N°01.\n"
						+ "    k) CABLE COLOR informa qe le asignará a EL ABONADO una dirección IP privado de tipo dinámica, salvo los planes "
						+ "''Internet Negocios'' en los que se asignará a las direcciones IP que se detallan ene l ANEXO N°01.",fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
			}else {
				
				hcell = new PdfPCell(new Phrase("Conste por el presente documento el contrato de Prestación de Servicios Públicos de"
						+ "Telecomunicaciones Distribución de Radiodifusion por cable (Televisión por cable) y/o Acceso a Internet - "
						+ "que celebran de una parte, VIP CHANNEL S.A.C. identificada con RUC N° 205150906400, con domicilio legal para "
						+ "los efectos del presente contrato en Av. Túpac Amaru N°306 2do piso-Huacho, en adelante CABLE COLOR; y de la "
						+ "otra parte:", fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(""
				   		+ "Sr./Sra ............................. identificado/a con D.N.I.: ............................. , con domicilio en "
				   		+ "............................. Empresa " + contrato.getCustomer() + " identificada con RUC N° " + contrato.getDocument()
				   		+ " con domicilio " + contrato.getDirection() + " representada por el señor(a) " + contrato.getName() + " según poder "
				   		+ "en inscrito en ............................. en adelante EL ABONADO, en los términos y condiciones siguientes:",fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase("PRIMERA.-",fantUnder));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(""
						+ "              CABLE COLOR es una empresa cuyo objeto social la faculta a prestar Servicios Públicos de "
						+ "Telecomunicaciones tales como Televisión por Cable,Televisión VHF,UHF,Internet y otros. \n"
						+ "Asimismo CABLE COLOR ha suscrito un Contrato de Concesión Única con el Ministerio de "
						+ "Transporte, Comunicaciones, Vivienda y Construcción para la Prestación de Servicios Públicos de Telecomunicaciones. \n"
						+ "Concesión única esta autorizada por Resolucón Ministerial N° 1053-2019-MTC/1.03.",fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase("SEGUNDA.-",fantUnder));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(""
						+ "                     Por el presente contrato CABLE COLOR se obliga a prestar a EL ABONADO lo siguiente: \n"
						+ "                     a) Servicio Público de Distribución de Radiofusión por Cable o Interneten el domicilio señalado en el\n"
						+ "                     Anexo N°1 que forma parte integrante del presente contrato. \n"
						+ "En adelante indistinta o conjuntamente se les denominará el Servicio",fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase("TERCERA.-",fantUnder));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(""
						+ "                     Restribución de EL ABONADO:",fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase("3.1.Respecto al Servicio Público de Distribución de Radiofusión por Cable",fantUnderCursive));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(""
						+ "La retribución que se obliga a pagar EL ABONADO se compone de un cargo único de conexión a la red y una tarifa peródica, cuyos montos se "
						+ "detallan en el ANEXO N°01. La facturación de la tarifa será efectuada por CABLE COLOR en el momento de la retribución "
						+ "o pago del servicio, desde la fecha de conexión del servicio a la red.\n"
						+ "El pago del cargo único por conexión, así como lo de la tarifa mensual deberá efectuarse por EL ABONADO en el lugar y en "
						+ "la oportunidad establecida en el ANEXO N°01 del contrato, bajo sanciónde quedar constituido en mora en forma automática.\n"
						+ "En caso de mora EL ABONADO se obliga a pagar, adicionalmente, los intereses legales máximos que fija el Banco Central de "
						+ "Reserva del Perú.\n"
						+ "Las tarifas que se consignan en el ANEXON°01 podrán ser modificadas por CABLE COLOR.\n"
						+ "CABLE COLOR podrá, si lo considera conveniente, exigir a EL ABONADO la constitución de una garantía que respalde  el pago "
						+ "del servicio contratado.",fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase("3.2.Respecto al Servicio Público de Acceso a Internet",fantUnderCursive));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(""
						+ "La retribución que se obliga a pagar EL ABONADO se compone de un cargo único de conexión al sistema pertinente "
						+ "y una tarifa periódica, cuyos montos se detallan en el ANEXO N°01 La facturación de la tarifa será efectuada por CABLE COLOR en el momento de la retribución \n"
						+ "o pago del servicio, desde la fecha de conexión del servicio a la red.\n"
						+ "El pago del cargo único por conexión, así como lo de la tarifa mensual deberá efectuarse por EL ABONADO en el lugar y en "
						+ "la oportunidad establecida en el ANEXO N°01 del contrato, bajo sanciónde quedar constituido en mora en forma automática.\n"
						+ "En caso de mora EL ABONADO se obliga a pagar, adicionalmente, los intereses legales máximos que fija el Banco Central de "
						+ "Reserva del Perú.\n"
						+ "Las tarifas que se consignan en el ANEXON°01 podrán ser modificadas por CABLE COLOR.\n"
						+ "CABLE COLOR podrá, si lo considera conveniente, exigir a EL ABONADO la constitución de una garantía que respalde  el pago "
						+ "del servicio contratado.",fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase("\nCUARTA.-",fantUnder));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(""
						+ "                     Instalación de Servicio:",fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase("4.1.Respecto al Servicio Público de Distribución de Radiofusión por Cable",fantUnderNotCursive));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(
						  "    a) CABLE COLOR instalará el servicio siempre y cuando existan las facilidades técnicas del caso.\n"
						+ "        La instalación del servicio supone la conexión de un(1) receptor a la red de distribución. EL ABONADO "
						+ "podrá solicitar la conexión de receptores adicionales, para lo cual deberá pagar los cargos"
						+ "correspondientes.\n"
						+ "    b) Por razones de mantenimiento CABLE COLOR podrá suspender temporalmente el servicio, en forma total o parcial.\n"
						+ "    c) Los equipos, materiales y accesorios instalados para la prestación del servicio son propiedad de CABLE COLOR.\n"
						+ "       EL ABONADO no podrá manipular, ceder, compartir, conectar sustituir ni efectuar modificaciones en los elementos "
						+ "instalados por CABLE COLOR, siendo responsables por los daños que pudieran sufir los mismos, así como pérdida, "
						+ "destrucción o deterioro, excepto cuando medie caso fortuito o fuerza mayor, sin perjuicio de las demás "
						+ "responsabilidades que pudieran derivarse por la manipulación indebida de tales elementos.",fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(
						  "    d) Las averíasdeficientes e interrupciones del servicio originadas en los equipos e instalaciones de CABLE COLOR "
						+ "serán subsanadas por ésta en el más breve plazo desde que tenga conocimiento de ellas. La reparación de averías se efectuará "
						+ "sin cargo alguno por EL ABONADO, salvo cuando las causas de su pcurrencia le sean imputable.\n"
						+ "    e) CABLE COLOR queda facultada asimismmp de suspender el servicio cuando la boleta y/o factura correspondiente al pago "
						+ "de la tarifa mensual, no es cancelado por EL ABONADO en la fecha de vencimiento, o EL ABONADO presenta un reclamo por facturación "
						+ "y no ha realizado el pago del monto que no se encuentra comprendido en el reclamo, en la fecha de vencimiento; esta suspensión "
						+ "se realizará a partir del día siguiente a este vencimiento. La suspensión se matendrá hasta que cesen las causas mencionadas, "
						+ "sin perjuicio de la facultad de CABLE COLOR de resolver el contrato, de conformidad con las normas legalesvigentes. En estos casos "
						+ "EL ABONADO aumirá el cargo de corte y reconexión delservicio, cuyo valor se encuentra consignado en el ANEXO del presente contrato.\n"
						+ "        No obstante lo anterior, EL ABONADO queda obligado a pagar la retribución mensual que corresponda hasta el día efectivo "
						+ "de suspensión del servicio.\n"
						+ "    f) Si transcurriesen veinte (20) días caendario después de la suspensión del servicio por falta de pago y EL ABONADO no cumpliera "
						+ "con su obligación de pago y siempre que no exista reclamo pendiente sobre el monto adeudado, CABLE COLOR podrá cortar el servicio de "
						+ "EL ABONADO, previa remisión de un aviso mediante documento que deje ocnstancia de la comunicación, con una anticipación no menor de "
						+ "de siete (7) días calendario a la fecha de corte.\n"
						+ "    g) Dicho aviso previo deberá indicar claramente el monto adeudado, la tasa de interés aplicable, el o los recibos no cabcelados que originaron "
						+ "la deuda, la fecha en que se efectuará el corte, la tarifa que se aplicará por la reactivación del servicio si de hace efectivo "
						+ "el corte y el plazo que tendrá EL ABONADO para cancelar su deuda antes de que se proceda a la baja definitivamente del servicio.\n"
						+ "    h) CABLE COLOR deberá reconectar el servicio cortado cuando se haya efectuado el pago de la totatlidad de la suma adeudada y el "
						+ "respectivol interés así como la tarifa por concepto de reconexión por corte.\n"
						+ "    i) EL ABONADO deberá efectuar el pago correspondiente dentro de los treinta (30) días calendario siguientes a la fecha en que se haya efectuado "
						+ "el corte. Transcurrido dicho plazo, CABLE COLOR podrá dar de baja el servicio.",fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase("4.2.Respecto al Servicio Público de Acceso a Internet",fantUnderNotCursive));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
				hcell = new PdfPCell(new Phrase(
						  "    a) CABLE COLOR realizará la configuración del Servicio. Usted deberá mantener en reserva y custodia sus cuentas "
						+ "y claves de acceso.\n"
						+ "    b) La velocidad de transmisión del Servicio depende, entre ellos, de: (i) el volumen de trafico y congestión de la red "
						+ "en internet; (ii) características técnicas y capacidades de su computadora; (iii) el uso excesivo de aplicacines ''peer to peer'' "
						+ "(punto a punto o P2P) u otras similares.\n"
						+ "    c) CABLE COLOR entregará en calidad de comodato, los equipos indicados en el ANEXO N°01, los cales son necesarios para "
						+ "la conexión y prestación del sericio.\n"
						+ "    d) EL ABONADO deberá utilizar el servicio cumpliendo con la normativa legal, moral, las buenas costumbres y el orden "
						+ "público relacionados con el uso de internet. Asimismo, deberá respetar las normas que regulan el envío y recepción "
						+ "de mensajes de correo electrónico con contenido publicitario no solicitado.\n"
						+ "    e) EL ABONADO no debe realizar las siguientes actividades: la pornografía infantil, el ''spam'', infrigir el secreto "
						+ "de las telecomunicaciones y la protección de datos personales; infringir los derechos de propiedad intelectual, realizar "
						+ "actividades de ''hacking'' y similares.\n"
						+ "    f) EL ABONADO no deberá realizar transmisiones o difusiones de materiales con contenidos que violen la legislación "
						+ "o propagar virus informáticos u otros programas dañinos.\n"
						+ "    g) CABLE COLOR asume responsabilidad por la prestación del Servicio en las condiciones pactadas. No asumirá "
						+ "responsabilidad por causas que no le sean directamente imputables, tales como: (i) los usos y contenidos de la "
						+ "información a la que usted acceda a través del Servicio; (ii) la información que le sea transmitida por terceros; (iii) "
						+ "la información albergada o transmitida en cualquiera de sus formas a través del Servicio qe le eprtenezca, siendo "
						+ "usted responsable por el contenido de la misma; y, (iv) averías y desperfectos en el Servicio derivados de los equipos que "
						+ "usted haya adquirido a terceros, de la manipulación indebida de los bienes que CABLE COLOR le pudiera haber proporcionado o de la "
						+ "configuración de la instalación que usted realice, en cuyo caso deberá asumir los costos de reparación.\n"
						+ "    h) EL ABONADO es responsable de las consecuencias del incumplimiento de los literales e), f) y g) del presente "
						+ "numeral.\n"
						+ "    i) La unidad de medición de la provisión de Servicio de acceso a internet es de kilobyte(KB).\n"
						+ "    j) La cobertura del Servicio se detalla en el ANEXO N°01.\n"
						+ "    k) CABLE COLOR informa qe le asignará a EL ABONADO una dirección IP privado de tipo dinámica, salvo los planes "
						+ "''Internet Negocios'' en los que se asignará a las direcciones IP que se detallan ene l ANEXO N°01.",fant));
				hcell.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
				hcell.setVerticalAlignment(Element.ALIGN_JUSTIFIED_ALL);
				hcell.disableBorderSide(Rectangle.BOX);
				table.addCell(hcell);
				
			}			
			
			String imageUrls = "file:///C:/Users/Luis/Desktop/OnBoarding/back/onboarding/src/main/resources/img/copia.jpg";
			
			Image imgs = Image.getInstance(new URL(imageUrls));
			imgs.disableBorderSide(Rectangle.BOX);
			imgs.setAbsolutePosition(0, 0); 
			
			PdfReader reader = new PdfReader("https://www.uv.mx/personal/artulopez/files/2012/08/02_TS-y-TI.pdf"); 
			int ns = reader.getNumberOfPages(); 
			
			PdfContentByte under; 
		    PdfContentByte over;
	    	
	    	PdfStamper stamp = new PdfStamper(reader,new FileOutputStream("1.pdf"));
			    
			PdfWriter.getInstance(documento, baos);
			documento.open();
			documento.add(imgs);
			documento.add(tableLogo);
			documento.add(table);
	    	for(int is=1; is<=ns; is++) {
		    	// Watermark under the existing page
		    	under = stamp.getUnderContent(is); 
		    	under.addImage(imgs);
	
		    	BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA,BaseFont.WINANSI, BaseFont.EMBEDDED);
		    	
		    	//Text over the existing page 
		    	over = stamp.getOverContent(is); 
		    	over.beginText(); 
		    	over.setFontAndSize(bf, 8); 
		    	over.setTextMatrix(is * 50,50);
		    	over.showText("76");
		    	over.endText(); 
				documento.add(imgs);
	    	}
			stamp.close();
			documento.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return new ByteArrayInputStream(baos.toByteArray());
	}
}