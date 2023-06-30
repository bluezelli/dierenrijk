<?php

namespace App\Controller;

use App\Entity\Dier;
use App\Entity\User;
use App\Form\AddDierType;
use App\Repository\UserRepository;
use Doctrine\ORM\EntityManagerInterface;
use http\Env\Request;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class AdminController extends AbstractController
{
    #[Route('/admin', name: 'admin')]
    public function index(UserRepository $userRepository): Response
    {
        $user = $this->getUser();
        $description = $userRepository->findAll();

        return $this->render('admin/index.html.twig', [
            'user' =>$user,
            'description' =>$description
        ]);
    }
    #[Route('/add', name: 'app_add')]
    public function add(Request $request, EntityManagerInterface $em): Response
    {
        $toevoegen = new Dier();

        $form = $this->createForm(AddDierType::class, $toevoegen);
        $form->handleRequest($request);
        if($form->isValid() && $form->isSubmitted()){
            $data = $form->getData();
                $em->persist($data);
                $em->flush();
                $this->addFlash('succes' , 'toegevoegd');
        }
        return $this->renderForm('admin/toevoegen.html.twig', [
            'form' =>$form
        ]);

    }
    #[Route('/delete/{id}', name: 'app_delete')]
    public function delete(int $id , EntityManagerInterface $em): Response
    {
        $delete = $em->getRepository(Dier::class)->find($id);
        if(!$delete){
            throw $this->createNotFoundException(
                'No product found for id' . $id

            );

        }
        $em->remove($delete);
        $this->addFlash('succes', 'verwijderd');
        return $this->redirectToRoute('admin');
    }



}
