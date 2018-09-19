<?php

namespace App\Controllers;

use Interop\Container\ContainerInterface;

class PageController
{
	protected $container;

	public function __construct(ContainerInterface $container)
	{
		$this->container = $container;
		$this->template = $this->container->get('plate');
	}

	public function index($request, $response, $args)
	{
		return $response->withRedirect("/home");
	}

	public function auth($request, $response, $args)
	{
		return $this->template->render("pages/auth");
	}

	public function home()
	{
		return $this->template->render("pages/home");
	}

	public function line()
	{
		return $this->template->render("pages/line");
	}

	public function profile()
	{
		return $this->template->render("pages/profile");
	}

	public function usermaster()
	{
		return $this->template->render("pagesmaster/user");
	}

	public function companymaster()
	{
		return $this->template->render("pagesmaster/company");
	}

	public function evaluationmaster()
	{
		return $this->template->render("pagesmaster/evaluation");
	}

	public function syncmaster()
	{
		return $this->template->render("pagesmaster/sync");
	}

	public function form()
	{
		return $this->template->render("pages/form");
	}

	public function test()
	{
		return $this->template->render("pages/test");
	}

	public function test2()
	{
		return $this->template->render("pages/test2");
	}

	public function askquestions()
	{
		return $this->template->render("report/askquestions");
	}
	
}