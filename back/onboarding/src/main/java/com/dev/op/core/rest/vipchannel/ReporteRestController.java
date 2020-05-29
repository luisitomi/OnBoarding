package com.dev.op.core.rest.vipchannel;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dev.op.core.dto.vipchannel.getListPayOneModel;
import com.dev.op.core.dto.vipchannel.getManagerSumationModel;
import com.dev.op.core.facade.vipchannel.CobranzaFacade;
import com.dev.op.core.view.vipchannel.pdf.PdfGenerator;

@RestController
@RequestMapping("/")
public class ReporteRestController {

	@Autowired
	@Qualifier("cobranzaFacade")
	private CobranzaFacade cobranzaFacade;
	
	@GetMapping(value = "planillaCajaUno", produces = MediaType.APPLICATION_PDF_VALUE)
	public ResponseEntity<InputStreamResource> planillaCajaUno() throws IOException {
		try {
			
			List<getListPayOneModel> planilla = cobranzaFacade.getListPayOne();
				
				ByteArrayInputStream bis = PdfGenerator.pdfPayOne(planilla);
				
				HttpHeaders headers = new HttpHeaders();
				headers.add("Content-Disposition", "inline; filename=planilla.pdf");
				
				return ResponseEntity.ok()
						.headers(headers)
						.contentType(MediaType.APPLICATION_PDF)
						.body(new InputStreamResource(bis));
		}
		catch(Exception e) {
				return new ResponseEntity<InputStreamResource>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping(value = "planillaCajaDos", produces = MediaType.APPLICATION_PDF_VALUE)
	public ResponseEntity<InputStreamResource> planillaCajaDos() throws IOException {
		try {
			
			List<getListPayOneModel> planilla = cobranzaFacade.getListPayOne();
				
				ByteArrayInputStream bis = PdfGenerator.pdfPayOne(planilla);
				
				HttpHeaders headers = new HttpHeaders();
				headers.add("Content-Disposition", "inline; filename=planilla.pdf");
				
				return ResponseEntity.ok()
						.headers(headers)
						.contentType(MediaType.APPLICATION_PDF)
						.body(new InputStreamResource(bis));
		}
		catch(Exception e) {
				return new ResponseEntity<InputStreamResource>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping(value = "planillaCajaTres", produces = MediaType.APPLICATION_PDF_VALUE)
	public ResponseEntity<InputStreamResource> planillaCajaTres() throws IOException {
		try {
			
			List<getListPayOneModel> planilla = cobranzaFacade.getListPayOne();
				
				ByteArrayInputStream bis = PdfGenerator.pdfPayOne(planilla);
				
				HttpHeaders headers = new HttpHeaders();
				headers.add("Content-Disposition", "inline; filename=planilla.pdf");
				
				return ResponseEntity.ok()
						.headers(headers)
						.contentType(MediaType.APPLICATION_PDF)
						.body(new InputStreamResource(bis));
		}
		catch(Exception e) {
				return new ResponseEntity<InputStreamResource>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping(value = "sumaGestor", produces = MediaType.APPLICATION_PDF_VALUE)
	public ResponseEntity<InputStreamResource> sumaGestor() throws IOException {
		try {
			
			List<getManagerSumationModel> sumation = cobranzaFacade.getManagerSumation();
				
				ByteArrayInputStream bis = PdfGenerator.pdfPaySumation(sumation);
				
				HttpHeaders headers = new HttpHeaders();
				headers.add("Content-Disposition", "inline; filename=planilla.pdf");
				
				return ResponseEntity.ok()
						.headers(headers)
						.contentType(MediaType.APPLICATION_PDF)
						.body(new InputStreamResource(bis));
		}
		catch(Exception e) {
				return new ResponseEntity<InputStreamResource>(HttpStatus.BAD_REQUEST);
		}
	}
	
}