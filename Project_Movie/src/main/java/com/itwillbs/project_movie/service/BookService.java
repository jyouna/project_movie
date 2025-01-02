package com.itwillbs.project_movie.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_movie.mapper.BookMapper;

@Service
public class BookService {
	@Autowired private BookMapper mapper;
}
